require 'spec_helper'

describe CoffeeViews::Handlers::CoffeeScript do
  
  def prepare source
    subject.prepare(source)
  end
  
  describe "Without substitutions" do
    it "should work with empty source" do
      prepare('').should == ''
      prepare(nil).should == ''
    end
  
    it "should prepare sources" do
      prepare("x").should == "x"
    end
  end
    
  describe "<%= code %>" do
    it "should wrap with `` and call #to_json on code" do
      prepare("<%=x%>").should == "`<%==(x).to_json%>`"
    end
  end
  
  describe "<%%>" do
    it "should wrap with ``" do
      prepare("<%x%>").should == "`<%x%>`"
    end
  end
  
  describe "<%==%>" do 
    it "should wrap with ``" do
      prepare("<%==x%>").should == "`<%==x%>`"
    end
  end
  
end