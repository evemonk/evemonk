# frozen_string_literal: true

class BlueprintCalculatorController < ApplicationController
  skip_before_action :authenticate_user!

  def index
  end

  def show
    @blueprint = Eve::Blueprint.find_by!(type_id: params[:id]).decorate
  end
end
