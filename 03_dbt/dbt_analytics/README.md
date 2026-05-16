Welcome to your new dbt project!

### Using the starter project

Try running the following commands:
- dbt run
- dbt test


### Resources:
- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [dbt community](https://getdbt.com/community) to learn from other analytics engineers
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices


### Visualisation de la documentation avec dbt fusion core
```
# genere les fichiers
dbt compile --write-catalog   

# pour recpere le fichier index.html

wget https://raw.githubusercontent.com/dbt-labs/dbt-core/main/core/dbt/task/docs/index.html -O target/index.html  

# servir localement la documentation generer:  http://localhost:8080 
cd target
python3 -m http.server 8080

```