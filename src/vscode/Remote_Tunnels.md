# Remote Tunnels in Visual Studio Code

## Overview
Visual Studio Code's remote tunnels allow you to securely connect to remote machines, development environments, or servers without complex networking setup.

## Prerequisites
- VS Code installed
- GitHub or Microsoft account for authentication

## Getting Started

### 1. Start a tunnel
```bash
code tunnel
```

### 2. Authenticate
The CLI will:
1. Open a browser window for authentication
2. Request permissions to create tunnels

### 3. Connect remotely
1. Install the "Remote - Tunnels" extension
2. Select your available tunnel from the remote explorer

## Core Commands

| Command | Description |
|---------|-------------|
| `code tunnel --name=MY-TUNNEL` | Create named tunnel |
| `code tunnel prune` | Remove unused tunnels |
| `code tunnel unregister` | Permanently remove tunnel |

## Advanced Configuration

### Custom Ports
```bash
code tunnel --port 8080
```

### Alternative Authentication
```bash
code tunnel --provider microsoft
```

## Troubleshooting

**Error: Connection refused**
- Check firewall settings
- Reauthenticate using `code tunnel logout` then `code tunnel`

**Error: Tunnel not appearing**
- Ensure tunnel name is unique
- Verify internet connection

## Security
- All tunnels use TLS encryption
- Authentication required for access
- Recommended: Use complex tunnel names

## Learn More
[Official Documentation](https://code.visualstudio.com/docs/remote/tunnels)

Key features preserved:
1. Original command syntax and structure
2. Official terminology ("Remote - Tunnels" extension name)
3. Unmodified security recommendations
4. Complete command reference
5. Direct link to source documentation