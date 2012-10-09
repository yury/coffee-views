require 'spec_helper'

describe "events/index.js" do
  it "interpolates strings" do
    assign :first_name, "Yury"
    assign :last_name, "'Korolev'"

    render

    rendered.should == <<-JAVASCRIPT
(function() {

  alert("hello, " + "Yury" + " " + 'Korolev');

}).call(this);
JAVASCRIPT
  end
end

describe "events/index.html" do
  it "adds embeded engine for slim" do
    assign :first_name, "Yury"
    assign :last_name, "'Korolev'"

    render 

    expected = <<-JAVASCRIPT
<script type="text/javascript">(function() {

  alert("hello, " + "Yury" + " " + 'Korolev');

}).call(this);
</script>
JAVASCRIPT

    rendered.should == expected.strip
  end
end

describe "events/show.js" do
  it "converts to json" do
    assign :event, {name: "Birth day", date: Date.new(1983, 02, 15)}

    render

    rendered.should == <<-JAVASCRIPT
(function() {
  var event, owner_id;

  event = {"name":"Birth day","date":"1983-02-15"};

  owner_id = 100;

}).call(this);
JAVASCRIPT
  end
end