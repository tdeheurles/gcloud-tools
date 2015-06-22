# import names
. ./release.cfg

artifact_tag="$servicemajor.$serviceminor.$BUILD_NUMBER"

# PRIVATE
  artifact_name="gcr.io/$projectid/$servicename"
  artifact_name_tagged="$artifact_name:$artifact_tag"

  # Build
  docker build -t $artifact_name .
  docker tag $artifact_name $artifact_name_tagged

  # Push to Google Cloud Engine
  gcloud preview docker push $artifact_name
  gcloud preview docker push $artifact_name_tagged


# PUBLIC
  public_artifact_name="$public_projectid/$servicename"
  public_artifact_name_tagged="$public_artifact_name:$artifact_tag"

  # tag
  docker tag -t $artifact_name $public_artifact_name
  docker tag -t $artifact_name $public_artifact_name_tagged

  # pull
  docker push $public_artifact_name
  docker push $public_artifact_name_tagged
