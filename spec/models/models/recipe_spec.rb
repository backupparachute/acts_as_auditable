require 'rails_helper'

module Models
  describe Recipe do

    it { should have_many :audits }
    it { should accept_nested_attributes_for(:audits) }

    let(:current_user){ create(:user) }

    describe "model" do
      let(:recipe){ Recipe }

      it "general model checks" do
        expect(subject.audits).to be_empty
      end

      it "general acts_as_auditable only method" do
        recipe.acts_as_auditable only: [:name]
        expect(recipe.permitted_columns).to include("name")
        expect(recipe.permitted_columns.size).to eql 1
      end

      it "general acts_as_auditable except method" do
        recipe.acts_as_auditable except: [:name]
        expect(recipe.excluded_cols).to include("name")
        expect(recipe.permitted_columns).not_to include("name")
      end
    end


    describe "update model with only name key" do
      let(:recipe){ create(:recipe) }

      let(:updated_model) do
        recipe.class.acts_as_auditable only: [:name]
        recipe.update_attribute(:name , "Foo" )
        recipe
      end

      let(:excluded_cols) do
        updated_model.class.excluded_cols & updated_model.audits.last.audited_changes.keys.map(&:to_s)
      end

      it "auditable should not save exluded cols in changes" do
        expect(excluded_cols).to be_empty
      end

      it "model should be associated" do
        expect(updated_model.audits).to have(2).audits
      end
    end


    describe "update model with exclusion key" do
      let(:recipe){ create(:recipe) }

      let(:updated_model) do
        recipe.class.acts_as_auditable except: [:name]
        recipe.update_attribute(:name , "Foo" )
        recipe
      end

      let(:excluded_cols) do
        updated_model.class.excluded_cols & updated_model.audits.last.audited_changes.keys.map(&:to_s)
      end

      it "auditable should not save exluded cols in changes" do
        expect(excluded_cols).to_not be_empty
      end

      it "model should be associated and not include name in audited_changes" do
        expect(updated_model.audits).to have(1).audits
        expect(updated_model.audits.first.audited_changes.keys).to_not include("name")
      end

      it "model should have an array of 2 values on audited changes " do
        updated_model.audits.last.audited_changes.keys.each do |key|
          expect(updated_model.audits.last.audited_changes[key.to_sym].size).to eql(2)
        end
      end
    end


    describe "update with audit comment" do
      let(:recipe){ create(:recipe) }

      let(:updated_model) do
        recipe.class.acts_as_auditable
        recipe.update_attributes(name: "Foo", audit_comment: "Some comment" )
        recipe
      end

      it "auditable should be created with comment" do
        expect(updated_model).to have(2).audits
        expect(updated_model.audits.last.comment).to_not be_empty
        expect(updated_model.audits.last.comment).to_not be "Some comment"
      end

      it "auditable should be created with comment" do
        expect(updated_model).to have(2).audits
        expect(updated_model.audits.last.version).to_not be_blank
        expect(updated_model.audits.last.version).to eql 2
      end
    end


    describe "save with current user" do
      before :each do
        RequestStore.store[:audited_user] = current_user
      end

      let(:recipe){ create(:recipe) }

      let(:updated_model) do
        recipe.class.acts_as_auditable
        recipe.update_attributes(name: "Foo", audit_comment: "Some comment" )
        recipe
      end

      it "auditable should set current user" do
        expect(updated_model.audits.last.user).to_not be_blank
        expect(updated_model.audits.last.user).to be_an_instance_of User
        expect(updated_model.audits.last.user).to eql current_user
      end
    end


    describe "audit defaults excepts" do
      let(:recipe) do
        [:create, :update, :destroy].each do |c|
          Recipe.reset_callbacks(c)
        end
        Recipe.acts_as_auditable on: [:update]
        create(:recipe)
      end

      let(:updated_model) do
        recipe.update_attributes(updated_at: 1.day.from_now )
        recipe
      end

      it "should have 1 audit" do
        expect(updated_model).to have(0).audits
      end
    end


    describe "audit only on create" do
      let(:recipe) do
        [:create, :update, :destroy].each do |c|
          Recipe.reset_callbacks(c)
        end
        Recipe.acts_as_auditable on: [:create]
        create(:recipe)
      end

      let(:updated_model) do
        recipe.update_attributes(name: "Foo", audit_comment: "Some comment" )
        recipe
      end

      it "should have 1 audit" do
        expect(updated_model).to have(1).audits
        expect(updated_model.audits.last.version).to_not be_blank
        expect(updated_model.audits.last.version).to eql 1
      end
    end


    describe "audit only on update" do
      let(:recipe) do
        [:create, :update, :destroy].each do |c|
          Recipe.reset_callbacks(c)
        end
        Recipe.acts_as_auditable on: [:update]
        create(:recipe)
      end

      let(:updated_model) do
        recipe.update_attributes(name: "Foo", audit_comment: "Some comment" )
        recipe
      end

      it "should have 1 audit" do
        expect(updated_model).to have(1).audits
        expect(updated_model.audits.last.version).to_not be_blank
        expect(updated_model.audits.last.version).to eql 1
      end
    end


    describe "audit when delete model" do
      let(:model) do
        [:create, :update, :destroy].each do |c|
          Recipe.reset_callbacks(c)
        end
        Recipe.acts_as_auditable on: [:destroy]
        create(:recipe)
      end

      it "should create 1 audit when destroy" do
        expect(model).to have(0).audits
        model.destroy
        expect(model).to have(1).audits
        expect(model.audits.last.comment).to include("deleted model #{model.id}")
      end
    end


    describe "has associated audits" do
      let!(:recipe) { create(:recipe) }
      let!(:comment) { create(:comment, recipe: recipe) }

      it "should list the associated audits" do
        expect(recipe.associated_audits.length).to eq(1)
        expect(recipe.associated_audits.first.auditable).to eq(comment)
      end
    end


    describe "associated with" do
      let!(:recipe) { create(:recipe) }
      let!(:comment) { create(:comment, recipe: recipe) }

      it "should record the associated object on create" do
        expect(comment.audits.first.associated).to eq(recipe)
      end

      it "should store the associated object on update" do
        comment.update_attributes(content: 'Comment content')
        expect(comment.audits.last.associated).to eq(recipe)
      end

      it "should store the associated object on destroy" do
        comment.destroy
        expect(comment.audits.last.associated).to eq(recipe)
      end
    end


    describe "revision for deleted records" do
      let(:recipe){ create(:recipe, name: '1') }
      it "should work" do
        recipe.destroy
        revision = recipe.audits.last.revision
        expect(revision.name).to eq(recipe.name)
        expect(revision).to be_a_new_record
      end
    end


    describe "revisions" do
      let(:recipe) do
        [:create, :update, :destroy].each do |c|
          Recipe.reset_callbacks(c)
        end
        Recipe.acts_as_auditable on: [:create, :update, :destroy]
        create(:recipe)
      end

      let(:updated_model) do
        5.times { |i| recipe.update(name: (i + 1).to_s, audit_comment: "Some comment") }
        recipe
      end

      it "should maintain identity" do
        expect(updated_model.revision(1)).to eq(recipe)
      end

      it "should find the given revision" do
        revision = updated_model.revision(3)
        expect(revision).to be_a_kind_of( Recipe )
        expect(revision.version).to eq(3)
        expect(revision.name).to eq('2')
      end

      it "should be able to get the previous revision repeatedly" do
        previous = updated_model.revision(:previous)
        expect(previous.version).to eq(5)
        expect(previous.revision(:previous).version).to eq(4)
      end

      it "should return an Array of Users" do
        expect(updated_model.revisions).to be_a_kind_of( Array )
        updated_model.revisions.each { |version| expect(version).to be_a_kind_of Recipe }
      end

      it "should have one revision for each audit" do
        expect(updated_model.audits.size).to eql( updated_model.revisions.size )
      end

      it "should set the attributes for each revision" do
        u = create(:recipe, name: 'Brandon', description: 'brandon')
        u.update_attributes(name: 'Foobar')
        u.update_attributes(name: 'Awesome', description: 'keepers')

        expect(u.revisions.size).to eql(3)

        expect(u.revisions[0].name).to eql('Brandon')
        expect(u.revisions[0].description).to eql('brandon')

        expect(u.revisions[1].name).to eql('Foobar')
        expect(u.revisions[1].description).to eql('brandon')

        expect(u.revisions[2].name).to eql('Awesome')
        expect(u.revisions[2].description).to eql('keepers')
      end

      it "access to only recent revisions" do
        u = create(:recipe, name: 'Brandon', description: 'brandon')
        u.update_attributes(name: 'Foobar')
        u.update_attributes(name: 'Awesome', description: 'keepers')

        expect(u.revisions(2).size).to eq(2)

        expect(u.revisions(2)[0].name).to eq('Foobar')
        expect(u.revisions(2)[0].description).to eq('brandon')

        expect(u.revisions(2)[1].name).to eq('Awesome')
        expect(u.revisions(2)[1].description).to eq('keepers')
      end

      it "should be empty if no audits exist" do
        updated_model.audits.delete_all
        expect(updated_model.revisions).to be_empty
      end

      it "should not raise an error when no previous audits exist" do
        updated_model.audits.destroy_all
        expect { updated_model.revision(:previous) }.to_not raise_error
      end

      it "should ignore attributes that have been deleted" do
        updated_model.audits.last.update_attributes :audited_changes => {:old_attribute => 'old value'}
        expect { updated_model.revisions }.to_not raise_error
      end

      it "should record new audit when saving revision" do
        expect {
          updated_model.revision(1).save!
        }.to change( recipe.audits, :count ).by(6)
      end

      it "should re-insert destroyed records" do
        u = create(:recipe)
        u.destroy
        expect {
          u.revision(1).save!
        }.to change( Recipe, :count ).by(1)
      end
    end


    describe "revision_at" do
      let( :recipe ) { create(:recipe) }

      it "should find the latest revision before the given time" do
        audit = recipe.audits.first
        audit.created_at = 1.hour.ago
        audit.save!
        recipe.update_attributes :name => 'updated'
        expect(recipe.revision_at( 2.minutes.ago ).version).to eq(1)
      end

      it "should be nil if given a time before audits" do
        expect(recipe.revision_at( 1.week.ago )).to be_nil
      end
    end

  end
end
