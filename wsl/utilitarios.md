# Utilitários

- [https://docs.microsoft.com/pt-br/windows/wsl/wsl-config](https://docs.microsoft.com/pt-br/windows/wsl/wsl-config)
- Diretório local padrão: \wsl$\

## Executando uma distribuição especifica

```powershell
wsl -d <NomeDaDistribuicao>
```

## Removendo uma distribuição

```powershell
wsl --unregister <NomeDaDistribuicao>
```

## Alterando a distribuição padrão

```powershell
wsl --set-default <NomeDaDistribuicao>
```

## Alterando a versão padrão do WSL

```powershell
wsl --set-default-version 2
```
