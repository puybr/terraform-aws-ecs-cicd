[
    {
      "essential": true,
      "name": "${app_name}",
      "image": "${app_image}",
      "networkMode": "awsvpc",
      "portMappings": [
          {
              "containerPort": ${app_port},
              "hostPort": ${app_port}
          }
        ]
    }
]