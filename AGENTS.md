You are scaffolding a complete GitHub repo named slurm-mini-hpc for a minimal Slurm demo cluster.

Objectives
Local demo via docker-compose: slurmctld, slurmdbd, two slurmd workers.

Example sbatch jobs: CPU hello, simple GPU training stub, NCCL all-reduce.

Optional VM deployment via Ansible (drivers/runtime + munge/slurm config).

Basic monitoring: Prometheus scrape config and exporter notes.

Makefile + CI + pre-commit; Apache-2.0 license.

Create this structure
bash
Copy
Edit
README.md
LICENSE
.gitignore
.pre-commit-config.yaml
.github/workflows/ci.yaml
Makefile
docker-compose.yml
conf/
  slurm.conf
  cgroup.conf
  gres.conf
  slurmdbd.conf
  munge.key.example
jobs/
  hello.sbatch
  gpu_train.sbatch
  nccl_allreduce.sbatch
ansible/
  inventory.example
  group_vars/all.yml
  roles/
    nvidia-driver/
      tasks/main.yml
    container-runtime/
      tasks/main.yml
    slurm/
      tasks/main.yml
monitoring/
  prometheus.yml
  README.md
scripts/
  fetch_nccl_tests.sh
ACCEPTANCE.md
File requirements (high level)
docker-compose.yml: volumes for /etc/slurm, /var/log/slurm, /var/lib/slurm; expose slurmctld 6817/6818; healthchecks; seeded DB for accounting.

conf/*: minimal, working configs with comments; munge.key.example is placeholder.

jobs/*:

hello.sbatch runs hostname + env.

gpu_train.sbatch checks for nvidia-smi, then runs a tiny CUDA container command or prints a friendly “no GPU” note.

nccl_allreduce.sbatch fetches/builds nccl-tests via scripts/fetch_nccl_tests.sh then runs all_reduce_perf -b 8 -e 512M -f 2.

Makefile targets with ## help: up, down, logs, submit-hello, submit-gpu, submit-nccl, lint.

README.md: quickstart (compose up), sbatch usage with sinfo/squeue/sacct tour, GPU note, NCCL test instructions, Ansible VM path, monitoring notes, troubleshooting, cleanup.

monitoring/README.md: point to node-exporter/Slurm exporter options; include prometheus.yml sample scrape config.

ansible/*: inventory example; roles: install NVIDIA driver (or container toolkit), container runtime, munge/slurm (systemd units, conf templating).

ci.yaml: pre-commit + yamllint + markdownlint; a job that runs docker compose config to validate.

.gitignore: Python base + node_modules/, .kube/, *.tgz, charts/, .DS_Store.

Acceptance checks (write in ACCEPTANCE.md)
make up brings cluster healthy (all services healthy).

make submit-hello finishes COMPLETED.

make submit-nccl runs all_reduce_perf on 2 tasks (ok if CPU-only prints informative message).

pre-commit run --all-files clean; CI passes.

docker compose down cleans volumes with make down.

Output format
Print each file as:

pgsql
Copy
Edit
=== path/to/file ===
<contents>
Do not include explanations outside files.

Prompt: triton-inference-helm
You are scaffolding a complete repo named triton-inference-helm to deploy NVIDIA Triton via Helm, with metrics and load-test.

Objectives
Helm chart to deploy Triton with a minimal model repository (e.g., ResNet50 ONNX).

HPA, readiness on model load, config for dynamic batching.

Locust load test against HTTP and/or gRPC.

Prometheus/Grafana wiring + ready-to-import dashboard JSON.

Makefile + CI + pre-commit; Apache-2.0 license.

Create this structure
bash
Copy
Edit
README.md
LICENSE
.gitignore
.pre-commit-config.yaml
.github/workflows/ci.yaml
Makefile
helm/
  Chart.yaml
  values.yaml
  templates/deployment.yaml
  templates/service.yaml
  templates/configmap-model-repo.yaml
  templates/hpa.yaml
  templates/pdb.yaml
model-repo/
  resnet50/1/README.md     # placeholder w/ fetch script or link
  resnet50/config.pbtxt
loadtest/
  locustfile.py
dashboards/
  triton-overview.json
scripts/
  fetch_resnet50_onnx.sh
ACCEPTANCE.md
File requirements (high level)
values.yaml: image (pin a public Triton tag), resources, GPU requests/limits, args enabling HTTP/GRPC/metrics, model repository mount (ConfigMap OR PVC), readiness/liveness, extraEnv for TRITON_SERVER_FLAGS.

deployment.yaml: mounts model repo, exposes 8000/8001/8002; readiness waits for repo-index or /v2/health/ready; tolerations and node selectors commented.

service.yaml: ClusterIP + optional annotations; port names http, grpc, metrics.

config.pbtxt: dynamic batching example with preferred sizes and queue delay.

locustfile.py: simple image POST load generator; parameterize concurrency and payload; prints P50/P95.

triton-overview.json: panels for request rate, latency, GPU util/mem, model load status (commented metrics names).

fetch_resnet50_onnx.sh: downloads a small ONNX model or gives instructions if bandwidth restricted.

Makefile: deploy, upgrade, uninstall, port-forward, load, lint, helm-lint.

README.md: quickstart (helm install), fetch model, port-forward, curl HTTP infer example, Locust run, dashboard import, dynamic batching demo, HPA notes, cleanup.

ci.yaml: markdown/yaml lint + helm lint + render template with helm template (dry-run).

.gitignore: Python base + charts/*, *.tgz, node_modules/.

Acceptance checks
make deploy succeeds; pods Ready and model loaded.

curl to /v2/health/ready returns 200.

make load runs Locust and prints basic stats.

helm lint and CI succeed.

Dashboard JSON imports into Grafana without errors.

Output format
Use the delimiter:

pgsql
Copy
Edit
=== path/to/file ===
<contents>
