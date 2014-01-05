#= require vendor
#= require ./application/view_controller
#= require_tree ./application

$ ->
  new PanelsController(el: "body")
