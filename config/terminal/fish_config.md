# global:  ~/.config/fish/config.fish
# recomendado:  ~/.config/fish/conf.d/mbm.fish

- Start docker using `ds`
```fish
function ds
        if sudo service docker status | grep -q "not running"
                sudo service docker start
        end
        sudo service docker status
end
```
