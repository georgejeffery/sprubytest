require "spec_helper"

RSpec.describe "LogParser" do
  it "is defined" do
    expect(defined?(LogParser)).to be_truthy
    expect(LogParser).to be_a(Class)
  end

  it "prints views" do
    testdata = File.open("testdata.log")
    test = LogParser.new(testdata)
    outputtest = test.print
    expect(outputtest).to include("4 views")
  end
end
