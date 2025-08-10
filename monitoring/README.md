# Monitoring

Use Prometheus with node-exporter and a Slurm exporter. Example scrape config:

```yaml
scrape_configs:
  - job_name: 'node-exporter'
    static_configs:
      - targets: ['slurmctld:9100','worker1:9100','worker2:9100']
  - job_name: 'slurm'
    static_configs:
      - targets: ['slurmctld:8080']
```
