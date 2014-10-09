require 'rails_helper'

class AuditsController < ActionController::Base

  def audit
    @recipe = FactoryGirl.create(:recipe)
    render nothing: true
  end

  def update_user
    current_user.update_attributes(password: 'foo')
    render nothing: true
  end

  private

  attr_accessor :custom_user
end


describe AuditsController, type: :controller do

  before(:each) do
    Recipe.acts_as_auditable
  end

  let(:recipe){ FactoryGirl.create(:recipe) }
  let(:user){ FactoryGirl.create(:user) }

  describe "POST audit" do

    it "should audit user" do
      # add current user accessor to controller
      AuditsController.send(:define_method, 'current_user=') {|user| self.instance_variable_set("@current_user", user)}
      AuditsController.send(:define_method, 'current_user') {self.instance_variable_get("@current_user")}

      controller.send(:current_user=, user)
      expect {
        post :audit
      }.to change( ActsAsAuditable::Audit, :count )

      expect(assigns(:recipe).audits.last.user).to be == user
      expect(assigns(:recipe).audits.last.remote_address).to be == "0.0.0.0"
    end

    it "should audit without current_user defined" do
      expect {
        post :audit
      }.to change( ActsAsAuditable::Audit, :count )

      expect(assigns(:recipe).audits.last.user).to be == nil
      expect(assigns(:recipe).audits.last.remote_address).to be == "0.0.0.0"
    end
  end

end
