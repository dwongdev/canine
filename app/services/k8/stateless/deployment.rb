class K8::Stateless::Deployment < K8::Base
  attr_accessor :service, :project, :name, :port, :environment_variables

  def initialize(service)
    @service = service
    @project = service.project
    @name = @project.name
    @port = @service.container_port
    @environment_variables = @project.environment_variables
  end
end
