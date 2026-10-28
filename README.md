# answer_shaper

**One capability bit from GBT V8, packaged standalone.** No. 246 of 341,
`system` domain (System).

<p>
<img alt="python" src="https://img.shields.io/badge/python-3.9%2B-blue">
<img alt="license" src="https://img.shields.io/badge/license-MIT-green">
<img alt="deps" src="https://img.shields.io/badge/runtime%20dependencies-0-brightgreen">
</p>

> 行动优先输出核（蒸馏自 2026-09-28 主人给的周榜截图 ayghri/i-have-adhd——截图只给仓库名，**未联网核验、未引用该仓任何代码/文本**；纪律取自本仓自己的沟通纪律与已有技能 gbt-adhd-mode，本件补**运行时可机检的核**）：`check` 五条确定性规则逐条判定（R1 首行是行动不是铺垫 · R2 有编号步骤 · R3 步骤≤5 · R4 无客套收尾 · R5 有下一步），零模型零出网零幻觉、每条带命中细节；`shape` **纯机械重排**（剥铺垫/抽编号步骤/截到 5 步），抽不出的原样进「未判定」区标需人看——**不替作者补写一字**。op=check/shape/where

That description is copied verbatim from the registry. `tests/test_spec.py` pins it,
so documentation drift fails the build instead of shipping quietly.

## What this package actually is

It is the **contract** for one capability: its name, its parameters, the values it
accepts, and whether it can change state that cannot be restored. It is not the
implementation — that lives in the runtime this bit was extracted from.

So `run()` goes through a narrow `Backend` protocol, and the default backend is a
stub that **says so**:

```
status="validated"   backend="stub"   data={"executed": false}
```

Never `status="ok"`. A stub that reports success is worse than no stub, because the
caller stops looking for the real thing.

## Install

```bash
git clone https://github.com/gbtweilai-star/gbt-answer-shaper.git
cd gbt-answer-shaper
python -m pip install -e ".[dev]"
```

## Use

```bash
python -m gbt_answer_shaper info                  # capability card
python -m gbt_answer_shaper spec --json           # machine-readable contract
python -m gbt_answer_shaper check --payload '{}'
python -m gbt_answer_shaper run   --payload '{}'
```

Real `info` output from this machine:

```text
answer_shaper  (system)  v1.0.0
----------------------------------------
行动优先输出核（蒸馏自 2026-09-28 主人给的周榜截图 ayghri/i-have-adhd——截图只给仓库名，**未联网核验、未引用该仓任何代码/文本**；纪律取自本仓自己的沟通纪律与已有技能 gbt-adhd-mode，本件补**运行时可机检的核**）：`check` 五条确定性规则逐条判定（R1 首行是行动不是铺垫 · R2 有编号步骤 · R3 步骤≤5 · R4 无客套收尾 · R5 有下一步），零模型零出网零幻觉、每条带命中细节；`shape` **纯机械重排**（剥铺垫/抽编号步骤/截到 5 步），抽不出的原样进「未判定」区标需人看——**不替作者补写一字**。op=check/shape/where

gated      : False
external   : False
multi-op   : True
params     : (none)
values     : check, shape, where
```

Wire a real implementation:

```python
from gbt_answer_shaper import run

class MyBackend:
    name = "my-backend"
    def invoke(self, cap, payload):
        return {"cap": cap, "handled": sorted(payload)}

result = run({}, backend=MyBackend())
assert result.status == "ok"
```

## Parameters

| name | required | notes |
|---|---|---|
| — | no | the registry declares no required parameters |

Registry hint (`params_hint`): (empty)

**注册表登记的取值 / 子动作（3 个）**：`check`、`shape`、`where`

Types are deliberately absent: the registry does not declare them, and an invented
type is worse than no type, because callers believe it.

## Boundaries

- Not gated: the registry marks this bit `safe: true`.
- No external service dependency declared.
- Multi-op (`multi_op: true`): several sub-actions share one name — read `op` before calling.
- No implementation ships here. Bring a backend; the protocol is one method.

## What this is not

Not a wrapper around a hosted API. Not a model. Not a promise that calling it does
anything on its own. It is the typed seam plus the validation, which is the part that
stays correct even when the implementation changes.

## Tests

```bash
python -m pytest
```

```text
20 passed, 3 skipped in 0.14s
```

## Provenance

| field | value |
|---|---|
| capability | `answer_shaper` |
| domain | `system` |
| handler | `answer_shaper` |
| safe | `True` (gated = `False`) |
| external | `False` |
| atlas page | [system/answer_shaper](https://github.com/gbtweilai-star/gbt-caps/blob/main/caps/system/answer_shaper.md) |
| full index | [https://github.com/gbtweilai-star/gbt-caps](https://github.com/gbtweilai-star/gbt-caps) |

The parent README says 348 capabilities; an AST pass over the registry enumerates
`341 + 0 unimplemented + 0 disabled = 341`. The extra 7 are historical duplicates.
Numbering here follows 341 and matches the `gbt-caps` index one-to-one.

## License

MIT.
