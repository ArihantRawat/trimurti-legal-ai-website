import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';
import '../models/site_models.dart';

const trustBadges = <String>[
  'MIT Sandbox backed',
  'Building for law firms',
  'Stealth legal AI company',
  'Focused on sensitive legal work',
];

const trustSignals = <String>[
  'Built by Trimurti',
  'Backed by the MIT Sandbox Innovation Fund Program',
  'Designed for legal professionals',
  'Focused on privacy, sources, and review',
];

const whatWeDo = <FeatureItem>[
  FeatureItem(
    title: 'Drafting',
    description:
        'We are building tools to help legal teams move from matter notes to cleaner first drafts.',
    icon: Icons.edit_document,
    color: AppColors.blue,
  ),
  FeatureItem(
    title: 'Research',
    description:
        'We want research to feel faster, clearer, and easier to check before it becomes work product.',
    icon: Icons.travel_explore,
    color: AppColors.teal,
  ),
  FeatureItem(
    title: 'Matter Work',
    description:
        'We are bringing comments, tasks, versions, and checklists closer to the matter itself.',
    icon: Icons.account_tree,
    color: AppColors.purple,
  ),
];

const useCases = <UseCaseItem>[
  UseCaseItem(
    title: 'Drafting',
    description:
        'Move from matter context to cleaner first drafts while keeping review at the center.',
    icon: Icons.edit_document,
    color: AppColors.blue,
  ),
  UseCaseItem(
    title: 'Legal research',
    description:
        'Find useful sources faster and keep the path from search to memo easier to check.',
    icon: Icons.manage_search,
    color: AppColors.teal,
  ),
  UseCaseItem(
    title: 'Matter context',
    description:
        'Bring notes, drafts, tasks, and versions closer to the legal work they support.',
    icon: Icons.account_tree,
    color: AppColors.purple,
  ),
  UseCaseItem(
    title: 'Review',
    description:
        'Shape outputs around lawyer judgment, clear sources, and careful final review.',
    icon: Icons.fact_check,
    color: AppColors.amber,
  ),
];

const buildPrinciples = <PrincipleItem>[
  PrincipleItem(
    title: 'Trust starts with restraint.',
    description:
        'We share the product direction at a high level while we build carefully for sensitive legal work.',
    label: 'Stealth by design',
  ),
  PrincipleItem(
    title: 'Legal work needs visible sources.',
    description:
        'Research and drafting flows should make it easier for lawyers to see what informed the work.',
    label: 'Clear sources',
  ),
  PrincipleItem(
    title: 'The lawyer stays in control.',
    description:
        'Juridical Loop OS is being shaped to support professional judgment, not replace it.',
    label: 'Lawyer review',
  ),
];

const whyTrimurti = <FeatureItem>[
  FeatureItem(
    title: 'Built for legal work',
    description:
        'We start with the way lawyers work with matters, drafts, sources, approvals, and client documents.',
    icon: Icons.balance,
    color: AppColors.deepNavy,
  ),
  FeatureItem(
    title: 'Clear experience',
    description: 'We want the product to feel calm, clear, and easy to use.',
    icon: Icons.workspace_premium,
    color: AppColors.amber,
  ),
  FeatureItem(
    title: 'Confidence at the center',
    description:
        'Every planned flow should make it easier for lawyers to check the work.',
    icon: Icons.verified_user,
    color: AppColors.teal,
  ),
];

const workflowFeatures = <FeatureItem>[
  FeatureItem(
    title: 'Matter organization',
    description:
        'Keep drafts, comments, tasks, checklists, contacts, and versions in one place for each matter.',
    icon: Icons.folder_special,
    color: AppColors.blue,
  ),
  FeatureItem(
    title: 'Collaborative drafting',
    description:
        'Keep review notes, client changes, and next steps close to the draft.',
    icon: Icons.groups,
    color: AppColors.teal,
  ),
  FeatureItem(
    title: 'Operational clarity',
    description: 'Make it easier to see what changed and what needs attention.',
    icon: Icons.timeline,
    color: AppColors.purple,
  ),
];

const researchFeatures = <FeatureItem>[
  FeatureItem(
    title: 'Relevance-ranked research',
    description: 'Search should help lawyers find useful sources faster.',
    icon: Icons.manage_search,
    color: AppColors.blue,
  ),
  FeatureItem(
    title: 'Memo acceleration',
    description:
        'Research should help turn findings into outlines and review notes.',
    icon: Icons.description,
    color: AppColors.teal,
  ),
  FeatureItem(
    title: 'Citation-aware review',
    description: 'Keep sources close so lawyers can check the work.',
    icon: Icons.format_quote,
    color: AppColors.amber,
  ),
];

const securityFeatures = <FeatureItem>[
  FeatureItem(
    title: 'Sensitive information handling',
    description:
        'We are thinking carefully about how legal teams handle client and matter information.',
    icon: Icons.lock_outline,
    color: AppColors.deepNavy,
  ),
  FeatureItem(
    title: 'Access controls',
    description:
        'We are planning simple controls so the right people see the right work.',
    icon: Icons.admin_panel_settings,
    color: AppColors.blue,
  ),
  FeatureItem(
    title: 'Clear sources',
    description:
        'The experience is meant to keep answers tied to sources that lawyers can review.',
    icon: Icons.fact_check,
    color: AppColors.teal,
  ),
  FeatureItem(
    title: 'Built for review',
    description:
        'The product is being shaped around careful review and lawyer judgment.',
    icon: Icons.privacy_tip,
    color: AppColors.purple,
  ),
];

const howItWorks = <TimelineStep>[
  TimelineStep(
    label: '01',
    title: 'Connect',
    description:
        'Start a conversation with Trimurti about what your team wants to improve.',
  ),
  TimelineStep(
    label: '02',
    title: 'Map',
    description:
        'Share how your firm drafts, researches, reviews, communicates, and organizes matters today.',
  ),
  TimelineStep(
    label: '03',
    title: 'Shape',
    description: 'Help shape the product around real attorney needs.',
  ),
  TimelineStep(
    label: '04',
    title: 'Stay Close',
    description:
        'Follow progress and continue the conversation as the product takes shape.',
  ),
];

const faqs = <FaqItem>[
  FaqItem(
    question: 'What is Trimurti building?',
    answer:
        'Trimurti is building Juridical Loop OS, an AI workspace for modern law firms. We are starting with drafting, research, and matter work.',
  ),
  FaqItem(
    question: 'Who is Juridical Loop OS designed for?',
    answer:
        'It is for law firms and legal teams that want a better way to draft, research, organize work, and keep review clear.',
  ),
  FaqItem(
    question: 'How can interested firms get involved?',
    answer:
        'Contact us to learn more and tell us what your team needs. We are especially interested in real drafting and research pain points.',
  ),
  FaqItem(
    question: 'What principles guide the product?',
    answer:
        'We care about privacy, clear sources, access control, and giving lawyers work they can review with confidence.',
  ),
];
