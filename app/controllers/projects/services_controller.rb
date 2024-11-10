class Projects::ServicesController < Projects::BaseController
  before_action :set_project
  before_action :set_service, only: %i[update destroy]

  def index
    @services = @project.services
  end

  def new
    @service = @project.services.build
  end

  def create
    result = Services::Create.call(@project.services.build(service_params), params)
    if result.success?
      redirect_to project_services_path(@project), notice: "Service will be created on the next deploy."
    else
      redirect_to project_services_path(@project), alert: "Service could not be created."
    end
  end

  def update
    if @service.update(service_params)
      redirect_to project_services_path(@project), notice: "Service will be updated on the next deploy."
    else
      redirect_to project_services_path(@project), alert: "Service could not be updated."
    end
  end

  def destroy
    @service.destroy
    redirect_to project_services_path(@project), notice: "Service will be removed on the next deploy."
  end

  private

  def set_service
    @service = @project.services.find(params[:id])
  end

  def service_params
    params.require(:service).permit(
      :service_type,
      :command,
      :name,
      :container_port,
      :healthcheck_url,
      :replicas,
      :allow_public_networking,
    )
  end
end
