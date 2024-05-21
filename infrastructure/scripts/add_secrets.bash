cat <<EOF >./postgres.env
POSTGRES_PASSWORD=LTAIsupersecretkeyfordat
POSTGRES_USER=finenomore
POSTGRES_DB=finenomore
EOF

kubectl -n finenomore create secret generic finenomore-db --from-env-file=./postgres.env

kubectl -n finenomore get secrets finenomore-db -o yaml

cat <<EOF >./postgres.env
POSTGRES_PASSWORD=LTAIothersecretkeyfordat
POSTGRES_USER=finenomore
POSTGRES_DB=finenomore
EOF

kubectl -n finenomore-dast create secret generic finenomore-db --from-env-file=./postgres.env

rm ./postgres.env

cd ~/yc-courses-ru-devsecops-gitlab/
git checkout main
git filter-branch -f --tree-filter "sed -i.bak -e's/LTAIsupersecretkeyfordat/fakepassword/g' app/finenomore/__init__.py; rm -f app/finenomore/__init__.py.bak" HEAD
git filter-branch -f --tree-filter "sed -i.bak -e's/LTAIsupersecretkeyfordat/fakepassword/g' k8s/finenomore/templates/postgresql.yml; rm -f k8s/finenomore/templates/postgresql.yml.bak" HEAD
git gc --prune=now
git push --force

cat <<EOF >./finenomore.env
FLASK_SECRET_KEY="$(python3 -c 'import secrets; print(secrets.token_hex())')"
EOF

kubectl -n finenomore create secret generic finenomore-app --from-env-file=./finenomore.env
kubectl -n finenomore-dast create secret generic finenomore-app --from-env-file=./finenomore.env
rm ./finenomore.env
