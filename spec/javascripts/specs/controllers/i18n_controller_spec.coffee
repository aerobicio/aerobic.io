describe "I18nController", ->
  beforeEach ->
    @controller = new I18nController
      root:
        simple: "Hello World"
        replace: "My name is %{first_name} Bluth"
        nested:
          simple: "FooBar"
          replace: "There is always money in the %{stand_type} Stand!"

  describe "#t", ->
    it "should return a string when passed a valid translation key", ->
      chai.expect(@controller.t('root.simple')).to.equal("Hello World")

    it "should look up nested values", ->
      chai.expect(@controller.t('root.nested.simple')).to.equal("FooBar")

    it "should throw an error when passed an invalid translation key", ->
      chai.expect(=> @controller.t('lol')).to.throw("Invalid translation key path: lol")

    it "should allow for substitution within the translation", ->
      chai.expect(@controller.t('root.replace', values: {first_name: "Gob"})).to.equal("My name is Gob Bluth")
      chai.expect(@controller.t('root.nested.replace', values: {stand_type: "Banana"})).to.equal("There is always money in the Banana Stand!")

    describe "options hash", ->
      it "should allow prefixing of the translation lookup key", ->
        chai.expect(@controller.t('.replace', values: {stand_type: "Banana"}, options: {prefix: 'root.nested'})).to.equal("There is always money in the Banana Stand!")
        chai.expect(@controller.t('simple', options: {prefix: 'root.nested'})).to.equal("FooBar")
        chai.expect(@controller.t('.simple', options: {prefix: 'root.nested'})).to.equal("FooBar")
        chai.expect(@controller.t('.simple', options: {prefix: 'root.nested.'})).to.equal("FooBar")
