{ lib, inputs, snowfall-inputs, }: rec {
  override-meta = meta: package:
    package.overrideAttrs (attrs: { meta = (attrs.meta or { }) // meta; });
}
