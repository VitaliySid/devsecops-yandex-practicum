yc iam service-account create --name ycr-pusher

# done (1s)
# id: aje5to05en8iru45oaco
# folder_id: b1gl3metlnuer73pnqmi
# created_at: "2024-05-21T07:58:15.966875920Z"
# name: ycr-pusher

yc resource-manager folder add-access-binding b1gl3metlnuer73pnqmi \
    --role container-registry.images.pusher \
    --subject serviceAccount:aje5to05en8iru45oaco

# effective_deltas:
#   - action: ADD
#     access_binding:
#       role_id: container-registry.images.pusher
#       subject:
#         id: aje5to05en8iru45oaco
#         type: serviceAccount

yc iam key create --service-account-name ycr-pusher -o key.json

yc container registry get finenomore-registry

# id: crpoa5fimv6i7llecfm5
# folder_id: b1gl3metlnuer73pnqmi
# name: finenomore-registry
# status: ACTIVE
# created_at: "2024-05-14T08:27:53.366Z"

yc container image list --repository-name=crpoa5fimv6i7llecfm5/finenomore
# +----------------------+---------------------+---------------------------------+----------------+-----------------+
# |          ID          |       CREATED       |              NAME               |      TAGS      | COMPRESSED SIZE |
# +----------------------+---------------------+---------------------------------+----------------+-----------------+
# | crpattsm513mvn18fgfh | 2024-05-21 09:54:24 | crpoa5fimv6i7llecfm5/finenomore | latest, v1.0.0 | 52.7 MB         |
# +----------------------+---------------------+---------------------------------+----------------+-----------------+

yc container image scan crpattsm513mvn18fgfh

# done (1m1s)
# id: chepr5fnfb3nrnf5og7u
# image_id: crpattsm513mvn18fgfh
# scanned_at: "2024-05-21T10:34:32.550Z"
# status: READY
# vulnerabilities:
#   high: "24"
#   medium: "32"
#   low: "2"
