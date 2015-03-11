class ActiveRecord::Base     

  class << self

    def pagination_by_params( page_params = {} )
      if page_params.blank?
        self
      else
        page(page_params[:page]).per(page_params[:page_size])
      end
    end

  end

end