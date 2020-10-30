# ACA-PY in Docker

This is a containerized version of aca-py (aries-cloudagent-python).

## Configuration

The easiest way to configure the agent is to use environment variables.
This is not properly documented by aries currently, but all the ENV vars
and command line variables can be found [on github](https://github.com/hyperledger/aries-cloudagent-python/blob/master/aries_cloudagent/config/argparse.py).

### Provision

The config variables needed for provisioning are given below.

| Variable            | Purpose                                                                                                             |
| ------------------- | ------------------------------------------------------------------------------------------------------------------- |
| `ACAPY_ENDPOINT`    | Endpoint where agent will be available, put in DIDDoc. For instance `http://my-domain.example.com:8000/indy-agent`. |
| `ACAPY_GENESIS_URL` | Resolvable URL to genesis transactions (see docs for alternatives)                                                  |
| `ACAPY_WALLET_SEED` | Seed used to generate DID. DID needs to be registered before provisioning                                           |
| `ACAPY_WALLET_KEY`  | Key used to encrypt local wallet                                                                                    |
| `ACAPY_WALLET_NAME` | Can be `default`                                                                                                    |
| `ACAPY_WALLET_TYPE` | Must be `indy`                                                                                                      |

### Start

The config vars needed for running the agent are listed below.

| Variable                    | Purpose                                                                                                    |
| --------------------------- | ---------------------------------------------------------------------------------------------------------- |
| `ACAPY_ENDPOINT`            | Endpoint where agent will be available (should match endpoint from provision step)                         |
| `ACAPY_GENESIS_URL`         | Resolvable URL to genesis transactions (see docs for alternatives)                                         |
| `ACAPY_WALLET_SEED`         | Seed used to generate DID. DID needs to be registered before provisioning                                  |
| `ACAPY_WALLET_KEY`          | Key used to encrypt local wallet                                                                           |
| `ACAPY_WALLET_NAME`         | Can be `default`                                                                                           |
| `ACAPY_WALLET_TYPE`         | Must be `indy`                                                                                             |
| `ACAPY_INBOUND_TRANSPORT`   | Should be set to `http 0.0.0.0 <port>`, where port matches the endpoint port (default 80 for http)         |
| `ACAPY_OUTBOUND_TRANSPORT`  | Should be set to `http`                                                                                    |
| `ACAPY_ADMIN`               | Should be set to `0.0.0.0 <port>`, for admin api                                                           |
| `ACAPY_ADMIN_API_KEY`       | Should be used by client in `X-API-Key` header for http api requests                                       |
| `ACAPY_ADMIN_INSECURE_MODE` | Can be used instead of admin api key if you are sure the api interface is only reachable from safe clients |
| `ACAPY_DEBUG_CONNECTIONS`   | For additional debug info from connections (set to 1)                                                      |
| `ACAPY_DEBUG_CREDENTIALS`   | For additional logging from credential exchanges (set to 1)                                                |

There are also a lot of `ACAPY_AUTO_ACCEPT_<X>` ENV vars that can
automate various activities like issuing and verifying credentials. See
the link above.

## Running

Running the agent takes two steps, after you have a Hyperledger Indy
network running (using von-network for instance), and registered your
DID, you first need to provision the agent to generate a wallet and
publish a DIDDoc to the Indy network. Make sure the environment
variables are set as above, then run

```bash
docker run -vlogs:/home/indy/logs -vindy_client:/home/indy/.indy_client <acapy-image-tag> provision
```

After provisioning successfully, you can start the agent:

```bash
docker run -p<endpoint-port>:<endpoint-port> -p<admin-port>:<admin-port> -vlogs:/home/indy/logs -vindy_client:/home/indy/.indy_client <acapy-image-tag> start
```
