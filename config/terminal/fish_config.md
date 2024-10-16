# Configurações para o `fish shell`
- Globais: `~/.config/fish/config.fish`
- Customizadas (recomendado): `~/.config/fish/conf.d/*.fish`

- Start docker using `ds`
```fish
function ds
        if sudo service docker status | grep -q "not running"
                sudo service docker start
        end
        sudo service docker status
end
```
