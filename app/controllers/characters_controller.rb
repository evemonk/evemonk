# frozen_string_literal: true

class CharactersController < ApplicationController
  def index
    @characters = policy_scope(Character)
      .includes(:alliance, :corporation)
      .order(created_at: :asc)
      .page(params[:page])
      .decorate
  end

  def new

  end

  def show
  end

  def destroy
  end
end
