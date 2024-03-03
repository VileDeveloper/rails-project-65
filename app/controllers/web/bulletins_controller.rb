# frozen_string_literal: true

module Web
  class BulletinsController < Web::ApplicationController
    before_action :set_bulletin, only: %i[update show edit to_moderate archive]

    def index
      @q = Bulletin.where(state: :published).order(title: :desc).ransack(params[:q])
      @bulletins = @q.result(distinct: true).page(params[:page]).per(25)
    end

    def show
      authorize @bulletin
    end

    def new
      @bulletin = Bulletin.new
    end

    def edit
      authorize @bulletin
    end

    def create
      @bulletin = current_user.bulletins.build(bulletin_params)

      if @bulletin.save
        redirect_to profile_path, notice: t('.success')
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      authorize @bulletin

      if @bulletin.update(bulletin_params)
        redirect_to profile_path, notice: t('.success')
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def to_moderate
      authorize @bulletin

      if @bulletin.may_to_moderate?
        @bulletin.to_moderate!

        redirect_to profile_path, notice: t('.success')
      else
        redirect_to profile_path, alert: t('.failure')
      end
    end

    def archive
      authorize @bulletin

      if @bulletin.may_archive?
        @bulletin.archive!

        redirect_to profile_path, notice: t('.success')
      else
        redirect_to profile_path, alert: t('.failure')
      end
    end

    private

    def set_bulletin
      @bulletin = Bulletin.find(params[:id])
    end

    def bulletin_params
      params.require(:bulletin).permit(:title, :description, :image, :category_id)
    end
  end
end
