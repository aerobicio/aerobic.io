#= require support/sinon
#= require q/q

class GarminStubs
  _stubs: []
  _garminDevicesBuffer: []

  constructor: ->
    @_stubs['Garmin.unlock']  = @_stubGarminUnlock()
    @_stubs['Garmin.devices'] = @_stubGarminDevices()

  _stubGarminUnlock: ->
    sinon.stub(Garmin.prototype, 'unlock')

  _stubGarminDevices: ->
    deferred = Q.defer()
    deferred.resolve(@_garminDevicesBuffer)
    stub = sinon.stub(Garmin.prototype, 'devices')
    stub.returns(deferred.promise)
    stub

  restoreAll: ->
    _.invoke(@_stubs, 'restore')

  createFITDevice: ->
    @_garminDevicesBuffer.push {
      name: "TEST"
    }

  createTCXDevice: ->
    @_garminDevicesBuffer.push {
      name: "TEST"
    }

window.GarminStubs = new GarminStubs
