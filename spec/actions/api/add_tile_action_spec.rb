require File.join(File.dirname(__FILE__), "../actions_helper.rb")
require File.join(File.dirname(__FILE__), "../../../application")

describe "/add_tile" do

  context_for_cramp_app do
    def app
      # What's possible:
      # HomeAction
      # CrampApp::Application.routes
      # nil or not override at all -> will use config.ru in the root dir.
    end
    
    before(:each) do
      CrampApp::Application.clear!
    end
    
    context "routes" do
      it "should work as POST method" do
        result = post "/add_tile", :tile => "Lorem"
        result.should be_ok
        result.body.should == "ok"
      end
    
      it "should not work as GET method" do
        result = get "/add_tile", :tile => "Lorem"
        result.should_not be_ok
      end
    end
    
    context "game" do
      let(:game) { CrampApp::Application.find_game }
    
      it "should add tile to the game" do
        renderer = mock("renderer").as_null_object
        renderer.should_receive(:render_tiles).with(['Lorem', 'Ipsum'])
        post "/add_tile", :tile => "Lorem"
        post "/add_tile", :tile => "Ipsum"
        game.render(renderer)
      end
    end
  end
  
end