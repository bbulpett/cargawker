class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :prepare_meta_tags, if: "request.get?"
  before_filter :block_ip_addresses
  before_filter :configure_permitted_parameters, if: :devise_controller?

  def prepare_meta_tags(options={})

    site_name        = "CarGawker"
    title       = [controller_name, action_name].join(" ")
    description = "A social image gallery for Sport and Classic Cars"
    image       = options[:image] || "../../../assets/images/car_icon.png"
    current_url = request.url

    # Let's prepare a nice set of defaults

    defaults = {
      site:        site_name,
      title:       title,
      image:       image,
      description: description,
      keywords:    %w[cargawker car gawker car-gawker car gallery],
      twitter:     {site_name: site_name,
                    site: '@cargawker',
                    card: 'summary',
                    description: description,
                    image: image},
      og:          {url: current_url,
                    site_name: site_name,
                    title: title,
                    image: image,
                    description: description,
                    type: 'website'}
    }


    options.reverse_merge!(defaults)


    set_meta_tags options

  end

  protected
  	def configure_permitted_parameters
	    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation) }
	    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :username, :email, :password, :remember_me) }
	    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :email, :password, :password_confirmation, :current_password) }
  	end

    def block_ip_addresses
      head :unauthorized if current_ip_address == "24.196.174.32"
    end

    def current_ip_address
      request.env['HTTP_X_REAL_IP'] || request.env['REMOTE_ADDR']
    end
end
