require 'pencil_pusher/form_builder'
require 'pencil_pusher/matchers'
require 'pencil_pusher/have_errors'
require 'pencil_pusher/have_int_field'
require 'pencil_pusher/have_required_choice_field'
require 'pencil_pusher/have_required_field'
require 'pencil_pusher/have_required_float_field'
require 'pencil_pusher/have_required_int_field'
require 'pencil_pusher/have_required_text_field'
require 'pencil_pusher/have_text_field'

module PencilPusher
  module SpecHelpers
    include PencilPusher::Matchers
  end
end
