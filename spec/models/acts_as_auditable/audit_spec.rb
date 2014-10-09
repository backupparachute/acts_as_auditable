require 'rails_helper'

module ActsAsAuditable
  describe Audit do
    ## Relations
    it { should belong_to(:user) }
    it { should belong_to(:auditable) }
    it { should belong_to(:associated) }

    ## Serialization
    it { should serialize(:audited_changes) }


    describe "new_attributes" do
      it "should return a hash of the new values" do
        new_attributes = ActsAsAuditable::Audit.new(:audited_changes => {:a => [1, 2], :b => [3, 4]}).new_attributes
        expect(new_attributes).to eq({'a' => 2, 'b' => 4})
      end
    end

    describe "old_attributes" do
      it "should return a hash of the old values" do
        old_attributes = ActsAsAuditable::Audit.new(:audited_changes => {:a => [1, 2], :b => [3, 4]}).old_attributes
        expect(old_attributes).to eq({'a' => 1, 'b' => 3})
      end
    end


    describe "as_user" do
      let(:user){ create(:user) }
      it "should record user objects" do
        ActsAsAuditable::Audit.as_user(user) do
          recipe = create(:recipe, name: 'The auditors')
          recipe.name = 'The Auditors, Inc'
          recipe.save
          recipe.audits.each do |audit|
            expect(audit.user).to eq(user)
          end
        end
      end
    end

    describe "audited_classes" do
      class CustomUser < ::ActiveRecord::Base
      end

      class CustomUserSubclass < CustomUser
        acts_as_auditable
      end

      it "should include audited classes" do
        expect(ActsAsAuditable::Audit.audited_classes).to include(Recipe)
      end

      it "should include subclasses" do
        expect(ActsAsAuditable::Audit.audited_classes).to include(CustomUserSubclass)
      end
    end

    it "should set the request uuid on create" do
      recipe = create(:recipe)
      expect(recipe.audits(true).first.request_uuid).not_to be_blank
    end

  end
end
