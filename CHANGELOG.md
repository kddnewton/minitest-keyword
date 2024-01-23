# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/) and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [2.0.0] - 2024-01-23

### Changed

- `assert_send` is no longer decorated, since it is deprecated.
- `assert_operator` and `refute_operator` have changed their keywords from `o1`, `op`, and `o2` to `receiver`, `operator`, and `argument`, respectively.
- `assert_predicate` and `refute_predicate` have changed their keywords from `o1` and `op` to `receiver` and `operator`, respectively.

## [1.0.2] - 2024-01-12

### Changed

- Support keyword arguments for `assert_respond_to` and `refute_respond_to`.

## [1.0.1] - 2021-11-17

### Changed

- Require MFA for releasing.

## [1.0.0] - 2019-01-06

### Changed

- The name of the underlying parameter changed for `assert_in_epsilon` from `a` and `b` to `exp` and `act`. As such, in order to normalize, those were aliased to `expected` and `actual` as well.

[unreleased]: https://github.com/kddnewton/minitest-keyword/compare/v2.0.0...HEAD
[2.0.0]: https://github.com/kddnewton/minitest-keyword/compare/v1.0.2...v2.0.0
[1.0.2]: https://github.com/kddnewton/minitest-keyword/compare/v1.0.1...v1.0.2
[1.0.1]: https://github.com/kddnewton/minitest-keyword/compare/v1.0.0...v1.0.1
[1.0.0]: https://github.com/kddnewton/minitest-keyword/compare/846f1f...v1.0.0
