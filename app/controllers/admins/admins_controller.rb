module Admins
  class AdminsController < ApplicationController
    before_action :authenticate_admin!
    layout 'admins'
  end
end
