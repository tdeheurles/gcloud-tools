# import names
. ./release.cfg

# artifact tag
artifact_tag="$servicemajor.$serviceminor.$BUILD_NUMBER"

# PUBLIC
public_artifact_name="$public_projectid/$servicename"
public_artifact_name_tagged="$public_artifact_name:$artifact_tag"

# Build
docker build -t $public_artifact_name .
docker tag $public_artifact_name $public_artifact_name_tagged

# push
docker push $public_artifact_name
docker push $public_artifact_name_tagged
