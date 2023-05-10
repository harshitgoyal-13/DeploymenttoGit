provider "github" {
  token = var.Gittoken
}

resource "github_repository" "demoJenkins" {
  name        = "demoJenkins"
  description = "I am deploying my python code to my repository. Now, I will use this repository by adding git hub plugin to Jenkins"
  visibility  = "public"
  auto_init = true
}

locals {
  folder_path = var.folderPath
  files       = fileset("${local.folder_path}", "**/*")
}


resource "github_repository_file" "pythonCode" {
  for_each = local.files
  repository = github_repository.demoJenkins.name
  file  = each.key
  content    = file("${local.folder_path}/${each.value}")
  commit_message      = "Managed by Terraform 8th time successfully"
}
