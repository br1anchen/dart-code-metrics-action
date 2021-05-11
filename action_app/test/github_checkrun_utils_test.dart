@TestOn('vm')
import 'package:dart_code_metrics/src/analyzers/models/issue.dart' as dcm;
import 'package:dart_code_metrics/src/analyzers/models/severity.dart' as dcm;
import 'package:dart_code_metrics_github_action_app/src/github_checkrun_utils.dart';
import 'package:dart_code_metrics_github_action_app/src/github_workflow_utils.dart';
import 'package:github/github.dart' as github;
import 'package:mocktail/mocktail.dart';
import 'package:source_span/source_span.dart';
import 'package:test/test.dart';

class GitHubWorkflowUtilsMock extends Mock implements GitHubWorkflowUtils {}

void main() {
  group('GitHubCheckRunUtils', () {
    late GitHubWorkflowUtilsMock workflowUtilsMock;

    setUp(() {
      workflowUtilsMock = GitHubWorkflowUtilsMock();
    });

    test('isSupportIssue returns true only for support issue', () {
      final utils = GitHubCheckRunUtils(workflowUtilsMock);

      final issueWithPath = dcm.Issue(
        ruleId: 'rule',
        documentation: Uri(),
        location: SourceSpan(
          SourceLocation(1, sourceUrl: Uri.parse('file://a.dart')),
          SourceLocation(1, sourceUrl: Uri.parse('file://a.dart')),
          '',
        ),
        severity: dcm.Severity.none,
        message: 'message',
      );

      final issueWithOutPath = dcm.Issue(
        ruleId: 'rule',
        documentation: Uri(),
        location: SourceSpan(SourceLocation(1), SourceLocation(1), ''),
        severity: dcm.Severity.none,
        message: 'message',
      );

      expect(utils.isSupportIssue(issueWithPath), isTrue);
      expect(utils.isSupportIssue(issueWithOutPath), isFalse);
    });

    group('severityToAnnotationLevel returns', () {
      test('github annotation level from dart_code_metrics severity', () {
        final utils = GitHubCheckRunUtils(workflowUtilsMock);

        expect(
          utils.severityToAnnotationLevel(dcm.Severity.warning),
          equals(github.CheckRunAnnotationLevel.warning),
        );
        verifyNever(() => workflowUtilsMock.logInfoMessage(any()));
      });

      test(
        'github annotation level notice from unknown dart_code_metrics severity',
        () {
          final utils = GitHubCheckRunUtils(workflowUtilsMock);

          expect(
            utils.severityToAnnotationLevel(dcm.Severity.none),
            equals(github.CheckRunAnnotationLevel.notice),
          );
          expect(
            verify(() => workflowUtilsMock.logInfoMessage(captureAny()))
                .captured,
            equals(['Unknow severity: none']),
          );
        },
      );
    });
  });
}