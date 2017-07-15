apt_update 'update' do
  action :update
end

package "nginx"

service "nginx" do
    action [:enable, :start]
end

log "done"
