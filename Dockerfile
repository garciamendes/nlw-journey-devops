# Pegar a imagem (docker hub)
FROM golang:1.22.4-alpine as builder

# Criar uma pastar para rodar dentro do mesmo, tudo que está a baixo
# Lembrete: Quando se cria ele já entra dentro da pastar
WORKDIR /journey

# Copiar os dois arquivo para dentro da minha pasta de trabalho (/journey)
COPY go.mod go.sum ./

# Instalando as dependecias
RUN go mod download && go mod verify

# Copiando tudo para dentro da minha pastar de trabalho (/journey)
COPY . .

# Buildando (-o(output) [Serve para passar onde será redicionado o build])
RUN go build -o /bin/journey ./cmd/journey/journey.go

FROM scratch

WORKDIR /journey

COPY --from=builder /bin/journey .

# Expondo a porta
EXPOSE 8080
ENTRYPOINT [ "./journey" ]
