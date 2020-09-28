class NonexistentCharacterError < StandardError
    def initialize(msg="The Character you've searched for is not in Star Wars")
        super
      end
end