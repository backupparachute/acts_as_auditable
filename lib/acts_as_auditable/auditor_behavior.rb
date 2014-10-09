module ActsAsAuditable
  module AuditorBehavior
    extend ActiveSupport::Concern

    included do
      class_attribute  :excluded_cols
      class_attribute  :audit_callbacks
      class_attribute  :audit_associated_with
      attr_accessor    :audit_comment
    end

    module ClassMethods

      @@default_excluded = %w(lock_version created_at updated_at created_on updated_on)

      def acts_as_auditable(options = {})
        self.audit_callbacks = []
        self.audit_callbacks << options[:on] unless options[:on].blank?
        self.audit_callbacks.flatten!

        after_create   :audit_create  if self.audit_callbacks.empty? || self.audit_callbacks.include?(:create)
        before_update  :audit_update  if self.audit_callbacks.empty? || self.audit_callbacks.include?(:update)
        before_destroy :audit_destroy if self.audit_callbacks.empty? || self.audit_callbacks.include?(:destroy)

        self.excluded_cols = @@default_excluded

        if options[:only]
          options[:only]     = [options[:only]].flatten.map { |x| x.to_s }
          self.excluded_cols = self.column_names - options[:only]
        end

        if options[:except]
          options[:except]   = [options[:except]].flatten.map { |x| x.to_s }
          self.excluded_cols = @@default_excluded + options[:except]
        end

        self.audit_associated_with = options[:associated_with]

        has_many :audits, as: :auditable, class_name: ActsAsAuditable::Audit.name
        ActsAsAuditable::Audit.audited_class_names << self.to_s

        accepts_nested_attributes_for :audits

        attr_accessor :version
      end


      def has_associated_audits
        has_many :associated_audits, as: :associated, class_name: ActsAsAuditable::Audit.name
      end


      def permitted_columns
        self.column_names - self.excluded_cols.to_a
      end


      # All audits made during the block called will be recorded as made
      # by +user+. This method is hopefully threadsafe, making it ideal
      # for background operations that require audit information.
      def as_user(user, &block)
        RequestStore.store[:audited_user] = user
        yield
      ensure
        RequestStore.store[:audited_user] = nil
      end

    end


    # Gets an array of the revisions available
    #
    #   user.revisions.each do |revision|
    #     user.name
    #     user.version
    #   end
    #
    def revisions(from_version = 1)
      audits = self.audits.from_version(from_version)
      return [] if audits.empty?
      revisions = []
      audits.each do |audit|
        revisions << audit.revision
      end
      revisions
    end


    # Get a specific revision specified by the version number, or +:previous+
    def revision(version)
      revision_with ActsAsAuditable::Audit.reconstruct_attributes(audits_to(version))
    end


    # Find the oldest revision recorded prior to the date/time provided.
    def revision_at(date_or_time)
      audits = self.audits.up_until(date_or_time)
      revision_with ActsAsAuditable::Audit.reconstruct_attributes(audits) unless audits.empty?
    end


    # audited attributes detected against permitted columns
    def audited_attributes
      self.changes.keys & self.class.permitted_columns
    end


    def audited_hash
      Hash[ audited_attributes.map{|o| [o.to_sym, self.changes[o.to_sym] ] } ]
    end


    protected


      def revision_with(attributes)
        self.dup.tap do |revision|
          revision.id = id
          revision.send :instance_variable_set, '@attributes', self.attributes
          revision.send :instance_variable_set, '@new_record', self.destroyed?
          revision.send :instance_variable_set, '@persisted', !self.destroyed?
          revision.send :instance_variable_set, '@readonly', false
          revision.send :instance_variable_set, '@destroyed', false
          revision.send :instance_variable_set, '@_destroyed', false
          revision.send :instance_variable_set, '@marked_for_destruction', false
          ActsAsAuditable::Audit.assign_revision_attributes(revision, attributes)

          # Remove any association proxies so that they will be recreated
          # and reference the correct object for this revision. The only way
          # to determine if an instance variable is a proxy object is to
          # see if it responds to certain methods, as it forwards almost
          # everything to its target.
          for ivar in revision.instance_variables
            proxy = revision.instance_variable_get ivar
            if !proxy.nil? and proxy.respond_to? :proxy_respond_to?
              revision.instance_variable_set ivar, nil
            end
          end
        end
      end


    private


      def audits_to(version = nil)
        if version == :previous
          version = if self.version
                      self.version - 1
                    else
                      previous = audits.descending.offset(1).first
                      previous ? previous.version : 1
                    end
        end
        audits.to_version(version)
      end


      def audit_create
        #puts self.class.audit_callbacks
        write_audit(:action => 'create',
                    :audited_changes => audited_hash,
                    :comment => audit_comment)
      end


      def audit_update
        #puts self.class.audit_callbacks
        write_audit(:action => 'update',
                    :audited_changes => audited_hash,
                    :comment => audit_comment)
      end


      def audit_destroy
        comment_description = ["deleted model #{id}", audit_comment].join(": ")
        write_audit(:action => 'destroy',
                    :audited_changes => self.attributes,
                    :comment => comment_description )
      end


      def write_audit(options)
        options[:associated] = self.send(audit_associated_with) unless audit_associated_with.nil?
        self.audits.create(options) unless options[:audited_changes].blank?
      end

  end
end
