# Directus

Docker-basiertes Directus CMS mit PostgreSQL und Redis-Caching.

## Voraussetzungen

- Docker und Docker Compose
- Externes Docker-Netzwerk `proxy_apps` (für Reverse Proxy)

## Installation

1. Ersteinrichtung (interaktiv, generiert automatisch das Secret):

```bash
make init
```

2. Container starten:

```bash
make up
```

## Verfügbare Befehle

| Befehl | Beschreibung |
|--------|-------------|
| `make init` | Interaktive Ersteinrichtung (fragt Werte ab, generiert Secret) |
| `make up` | Container starten |
| `make up-pocketid` | Container mit Pocket ID Authentifizierung starten |
| `make down` | Container stoppen |
| `make restart` | Container neustarten |
| `make recreate` | Container neu erstellen |
| `make recreate-pocketid` | Container mit Pocket ID neu erstellen |
| `make pull` | Neueste Images herunterladen |
| `make logs` | Logs anzeigen |
| `make ps` | Container-Status anzeigen |
| `make config` | Docker Compose Konfiguration anzeigen |

## Architektur

- **Directus** (Port 8055) - Headless CMS
- **PostgreSQL** - Datenbank mit automatischem Upgrade und täglichem Backup (01:00 Uhr)
- **Redis** - Caching

## Pocket ID Authentifizierung

Für OpenID Connect Authentifizierung mit Pocket ID folgende Variablen in `.env` ergänzen:

```bash
AUTH_POCKETID_CLIENT_ID=
AUTH_POCKETID_CLIENT_SECRET=
AUTH_POCKETID_ISSUER_URL=
AUTH_POCKETID_DEFAULT_ROLE_ID=
AUTH_POCKETID_REDIRECT_ALLOW_LIST=
```

Dann mit `make up-pocketid` starten.

## Volumes

| Volume | Beschreibung |
|--------|-------------|
| `app_uploads` | Hochgeladene Dateien |
| `app_extensions` | Directus Extensions |
| `db_data` | PostgreSQL Daten und Backups |

## Automatische Updates

Der Container ist für Watchtower konfiguriert und führt nach Updates automatisch Datenbank-Migrationen aus.