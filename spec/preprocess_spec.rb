require 'spec_helper'

describe CoffeeViews::Rails::TemplateHandler do

  let(:handler) { subject.class }
  
  def preprocess source
    handler.preprocess(source)
  end
  
  describe "Without substitutions" do
    it "should work with empty source" do
      preprocess('').should == ''
      preprocess(nil).should == ''
    end
  
    it "should preprocess sources" do
      preprocess("x").should == "x"
    end
  end
    
  describe "<%= code %>" do
    it "should wrap with `` and call #to_json on code" do
      preprocess("<%=x%>").should == "`<%==CoffeeViews.j((x).to_json.html_safe)%>`"
    end
  end
  
  describe "<%%>" do
    it "should wrap with ``" do
      preprocess("<%x%>").should == "`<%x%>`"
    end
  end
  
  describe "<%==%>" do 
    it "should wrap with ``" do
      preprocess("<%==x%>").should == "`<%==x%>`"
    end
  end
  
  describe '#{= code}' do
    it "should wrap with `<%== %>` and call #to_json on code" do
      preprocess('alert "#{=code}"').should == 'alert "#{`<%==CoffeeViews.j((code).to_json.html_safe)%>`}"'
    end
  end

  describe '#{== code}' do
    it "should wrap with `<%== %>`" do
      preprocess('alert "#{==code}"').should == 'alert "#{`<%==code%>`}"'
    end
  end
  
end