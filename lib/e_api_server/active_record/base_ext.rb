module ActiveRecordExtension

  extend ActiveSupport::Concern

  module ClassMethods

    def pagination_by_params( page_params = {} )
      if page_params.blank?
        where(nil)
      else
        page(page_params[:page]).per(page_params[:page_size])
      end
    end

  end

end

ActiveRecord::Base.send(:include, ActiveRecordExtension)