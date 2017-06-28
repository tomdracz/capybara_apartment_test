require "rails_helper"

feature "Test feature spec" do
  before(:each) do
    @pw = "testpassword"
    @site = Site.find_by(name: "Test Site")
    @user = create(:user, password: @pw, password_confirmation: @pw)
    @site.users << @user
    Apartment::Tenant.switch! "test_site"
  end

  context "non-js" do
    scenario "login" do
      expect(ActiveRecord::Base.connection.schema_search_path).to include("test_site")
      login(@user.email, @pw)
      expect(ActiveRecord::Base.connection.schema_search_path).to include("test_site")
    end

    scenario "page visit" do
      expect(ActiveRecord::Base.connection.schema_search_path).to include("test_site")
      visit(pages_path)
      expect(ActiveRecord::Base.connection.schema_search_path).to include("test_site")
    end
  end

  context "js", js: true do
    scenario "login" do
      expect(ActiveRecord::Base.connection.schema_search_path).to include("test_site")
      login(@user.email, @pw)
      expect(ActiveRecord::Base.connection.schema_search_path).to include("test_site")
    end

    scenario "page visit" do
      expect(ActiveRecord::Base.connection.schema_search_path).to include("test_site")
      visit(pages_path)
      expect(ActiveRecord::Base.connection.schema_search_path).to include("test_site")
    end
  end
end
