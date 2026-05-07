const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});
    const test_step = b.step("test", "Run tests");

    const async_module = b.createModule(.{
        .root_source_file = b.path("src/async_test.zig"),
        .target = target,
        .optimize = optimize,
    });
    const async_tests = b.addTest(.{
        .root_module = async_module,
    });
    const async_run = b.addRunArtifact(async_tests);
    test_step.dependOn(&async_run.step);

    const batch_module = b.createModule(.{
        .root_source_file = b.path("src/batch_test.zig"),
        .target = target,
        .optimize = optimize,
    });
    const batch_tests = b.addTest(.{
        .root_module = batch_module,
    });
    const batch_run = b.addRunArtifact(batch_tests);
    test_step.dependOn(&batch_run.step);

    const contract_module = b.createModule(.{
        .root_source_file = b.path("src/contract_test.zig"),
        .target = target,
        .optimize = optimize,
    });
    const contract_tests = b.addTest(.{
        .root_module = contract_module,
    });
    const contract_run = b.addRunArtifact(contract_tests);
    test_step.dependOn(&contract_run.step);

    const detection_module = b.createModule(.{
        .root_source_file = b.path("src/detection_test.zig"),
        .target = target,
        .optimize = optimize,
    });
    const detection_tests = b.addTest(.{
        .root_module = detection_module,
    });
    const detection_run = b.addRunArtifact(detection_tests);
    test_step.dependOn(&detection_run.step);

    const error_module = b.createModule(.{
        .root_source_file = b.path("src/error_test.zig"),
        .target = target,
        .optimize = optimize,
    });
    const error_tests = b.addTest(.{
        .root_module = error_module,
    });
    const error_run = b.addRunArtifact(error_tests);
    test_step.dependOn(&error_run.step);

    const format_specific_module = b.createModule(.{
        .root_source_file = b.path("src/format_specific_test.zig"),
        .target = target,
        .optimize = optimize,
    });
    const format_specific_tests = b.addTest(.{
        .root_module = format_specific_module,
    });
    const format_specific_run = b.addRunArtifact(format_specific_tests);
    test_step.dependOn(&format_specific_run.step);

    const registry_module = b.createModule(.{
        .root_source_file = b.path("src/registry_test.zig"),
        .target = target,
        .optimize = optimize,
    });
    const registry_tests = b.addTest(.{
        .root_module = registry_module,
    });
    const registry_run = b.addRunArtifact(registry_tests);
    test_step.dependOn(&registry_run.step);

    const registry_operations_module = b.createModule(.{
        .root_source_file = b.path("src/registry_operations_test.zig"),
        .target = target,
        .optimize = optimize,
    });
    const registry_operations_tests = b.addTest(.{
        .root_module = registry_operations_module,
    });
    const registry_operations_run = b.addRunArtifact(registry_operations_tests);
    test_step.dependOn(&registry_operations_run.step);

    const smoke_module = b.createModule(.{
        .root_source_file = b.path("src/smoke_test.zig"),
        .target = target,
        .optimize = optimize,
    });
    const smoke_tests = b.addTest(.{
        .root_module = smoke_module,
    });
    const smoke_run = b.addRunArtifact(smoke_tests);
    test_step.dependOn(&smoke_run.step);

}
