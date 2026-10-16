---
name: dg-patch-vulnerabilities
description: Investigate and patch dependency or container vulnerabilities reported by Dependency-Track, Trivy, CVE, GHSA, or security scanners. Use when asked to fix, patch, assess, or prepare a PR for vulnerability findings in Digitec Galaxus repositories.
compatibility: Requires git, Docker, Trivy, and registry access when container images are involved.
---

# Patch Vulnerabilities

Find the real vulnerable artifact, apply the smallest safe fix, and prove the finding is gone.

## Rules

- Never rebuild first and assume the result represents the reported image.
- Never infer installed packages only from manifests. Inspect or scan the exact reported artifact.
- Never add ignores, VEX statements, scanner suppressions, or risk acceptances without explicit approval.
- Never patch vendored or bundled code by adding an unrelated top-level dependency.
- Never claim a fix from version comparison alone. Rebuild and rescan.
- Preserve unrelated worktree changes.
- Before editing files, present the exact files, changes, trade-offs, and verification plan. Wait for explicit approval.
- Do not commit, push, or create a PR unless explicitly requested.

## 1. Establish The Target

Collect the scanner, project/component, package name and version, severity, advisory identifier, image reference, tag, digest, and architecture.

For container findings:

1. Pull the exact reported image or digest.
2. Record the resolved digest with `docker image inspect`.
3. Scan that digest before changing code.
4. Prefer Trivy's registry source for registry artifacts:

```sh
trivy image --image-src remote --scanners vuln --format table <image>@<digest>
```

This avoids Docker 29/containerd image-store export incompatibilities. Use the local Docker source only when the image is not available from a registry.

Do not replace the reported image with a local build during diagnosis.

## 2. Identify The Real Origin

Classify every finding as one of:

- OS package
- direct application dependency
- transitive dependency
- build-only dependency left in the runtime artifact
- vendored or bundled dependency
- scanner false positive or stale SBOM

Use scanner paths, package metadata, lockfiles, package-manager dependency graphs, image history, and upstream manifests. For vendored Python dependencies, inspect the owning package's vendor manifest, such as pip's `src/pip/_vendor/vendor.txt`.

Do not confuse a separately installed package with a same-named vendored copy. They are different artifacts and require different fixes.

## 3. Validate The Advisory

Confirm using authoritative sources:

- affected version range
- first patched version
- exploit conditions and actual runtime exposure
- whether a fixed compatible release exists
- whether the package is used at runtime

Prefer the upstream security advisory and package/release metadata. Cross-check with at least one additional source such as GitHub Advisory Database, OSV, NVD, vendor security tracker, or package registry metadata.

Link the sources in the final result or PR description.

## 4. Select The Smallest Correct Fix

Prefer, in order:

1. Upgrade the direct owner to a compatible patched release.
2. Update a lock or constraint so the patched transitive version resolves.
3. Update the base image or OS package source.
4. Remove a build-only tool from the runtime artifact.
5. Restructure build/runtime stages when that materially improves artifact boundaries.
6. Document an upstream blocker when no safe patch exists.

Do not introduce a multi-stage build merely to look cleaner. Verify that it removes the vulnerable bytes from the final image. Base images may already contain tools such as pip.

If removal is proposed, prove the component is not needed at runtime and smoke-test all affected entry points.

If no fix exists, document:

- advisory and affected component
- why normal upgrades cannot fix it
- upstream issue or release being tracked
- exposure and temporary operational mitigation
- exact condition for removing the documentation

## 5. Present The Plan

Before edits, state:

- exact file paths
- exact dependency or image changes
- why the change fixes the real artifact
- compatibility or behavior risks
- build, smoke-test, and rescan commands
- any finding that remains blocked

Present the finding in an as short as possible and concise manner and wait for explicit approval.

## 6. Implement And Verify

After approval:

1. Make only the approved edits.
2. Run repository-native tests and validation.
3. Build the same target and architecture as production.
4. Verify application startup and affected entry points.
5. Inspect installed/runtime package versions.
6. Scan the rebuilt image with Trivy.
7. Confirm the original package names and advisory IDs no longer appear.
8. Report unrelated remaining vulnerabilities separately; do not expand scope silently.

For a local image that cannot be scanned through a registry, use Trivy's Docker source explicitly:

```sh
trivy image --image-src docker --scanners vuln --format table <local-image>
```

## 7. Prepare The PR

Keep the diff minimal. The PR description should contain:

- reported findings
- root cause and ownership chain
- implemented fix
- why alternatives were rejected
- verification commands and results
- remaining upstream blockers with links

Prepare commits or create the PR only when requested. Never include unrelated worktree changes.
