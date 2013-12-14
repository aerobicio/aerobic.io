#= require application/spinner_controller
#= require sinon

describe "SpinnerController", ->
  beforeEach ->
    @container = $("""
      <div id="my-spinner">
        <div class="spinner"></div>
      </div>
    """).appendTo "body"

  afterEach ->
    @container.remove()

  describe "presets", ->
    beforeEach ->
      @newSpinnerSpy = sinon.spy(app.controllers.SpinnerController.prototype, "_newSpinner")

    afterEach ->
      @newSpinnerSpy.restore()

    it "uses the 'tiny' preset by default", ->
      new app.controllers.SpinnerController
      expect(@newSpinnerSpy.calledWith('tiny')).toBeTruthy()

    it "uses the preset defined by the size option", ->
      new app.controllers.SpinnerController(preset: 'small')
      expect(@newSpinnerSpy.calledWith('small')).toBeTruthy()

    it "throws an error if the preset does not exist", ->
      expect(=> new app.controllers.SpinnerController(preset: 'skinny leg jeans')).toThrow(
        new Error("Unexpected preset 'skinny leg jeans'"))

  describe "controlling the spinner", ->
    describe "#destroy", ->
      beforeEach ->
        @controller = new app.controllers.SpinnerController el: @container
        @controller.destroy()

      afterEach ->
        @controller = null

      it "removes the spinner", ->
        expect(@controller.$el.find('.spinner').length == 0).toBeTruthy()

    describe "#show", ->
      beforeEach ->
        @controller = new app.controllers.SpinnerController el: @container

      it "returns itself", ->
        expect(@controller is @controller.show()).toBeTruthy()

      it "shows the spinner", ->
        @controller.show()
        expect(@controller.$el.find(".spinner").hasClass("is-shown")).toBeTruthy()

    describe "#hide", ->
      beforeEach ->
        @controller = new app.controllers.SpinnerController el: @container

      it "returns itself", ->
        expect(@controller is @controller.hide()).toBeTruthy()

      it "hides the spinner", ->
        @controller.hide()
        expect(@controller.$el.find(".spinner").hasClass("is-shown")).toBeFalsy()
