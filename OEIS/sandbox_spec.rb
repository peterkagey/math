require_relative 'sandbox'

describe Sandbox2 do

  context "an enum array of length 2" do

    context "with simple enumerators" do
      it "should properly stack enumerators" do
        enum_array = [1..2, 'a'..'c']
        expectation = [
          [1, 'a'],
          [1, 'b'],
          [1, 'c'],
          [2, 'a'],
          [2, 'b'],
          [2, 'c'],
        ]

        expect(Sandbox2::EnumArray.new(enum_array).explode).to eq(expectation)
      end
    end

    context "with arrays of arrays" do
      it "should properly stack them" do
        a = [
          [1, "a"],
          [1, "b"],
          [2, "a"],
          [2, "b"]
        ]
        b = "Y".."Z"
        expectation = [
          [1, "a", "Y"],
          [1, "a", "Z"],
          [1, "b", "Y"],
          [1, "b", "Z"],
          [2, "a", "Y"],
          [2, "a", "Z"],
          [2, "b", "Y"],
          [2, "b", "Z"],
        ]
        expect(Sandbox2::EnumArray.new([a,b]).explode).to eq(expectation)
      end
    end

  end

  context "an enum array of length 3" do
    context "with simple enumerators" do
      it "should properly stack enumerators" do
        enum_array = [1..2, 'a'..'c', 'Y'..'Z']
        expectation = [
          [1, 'a', 'Y'],
          [1, 'a', 'Z'],
          [1, 'b', 'Y'],
          [1, 'b', 'Z'],
          [1, 'c', 'Y'],
          [1, 'c', 'Z'],
          [2, 'a', 'Y'],
          [2, 'a', 'Z'],
          [2, 'b', 'Y'],
          [2, 'b', 'Z'],
          [2, 'c', 'Y'],
          [2, 'c', 'Z'],
        ]

        expect(Sandbox2::EnumArray.new(enum_array).explode).to eq(expectation)
      end
    end
  end

end
