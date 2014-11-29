json.projects @projects do |project|
  json.name project.name
  json.order project.order
  json.description project.description
end
