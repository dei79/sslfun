class CsrController < ApplicationController
  def new
    # get the aplication
    @app = App.find(params[:id])

    # generate the csr
    @csr = @app.app_key.generate_csr!("CN=ospl/DC=example")

    if @csr
      send_data(@csr.to_pem, :filename => "#{@app.name}.csr".downcase.tr(" ", "_"))
    else
      redirect_to :back
    end
  end
end
