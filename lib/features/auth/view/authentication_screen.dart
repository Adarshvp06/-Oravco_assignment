import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:oravco_assignment/core/constants/app_colors.dart';
import 'package:oravco_assignment/core/constants/constants.dart';
import 'package:oravco_assignment/core/routes/route_names.dart';
import 'package:oravco_assignment/core/utils/snackbar_utils.dart';
import 'package:oravco_assignment/core/widgets/common_botton.dart';
import 'package:oravco_assignment/features/auth/view_model/auth_viewmodel.dart';

import '../../../core/extension/theme_extension.dart';

class AuthenticationScreen extends ConsumerStatefulWidget {
  const AuthenticationScreen({super.key});

  @override
  ConsumerState<AuthenticationScreen> createState() =>
      _AuthenticationScreenState();
}

class _AuthenticationScreenState extends ConsumerState<AuthenticationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      ref.read(passwordVisibilityProvider.notifier).state = true;
      ref
          .read(authViewmodelProvider.notifier)
          .signIn(
            email: _emailController.text.trim(),
            password: _passwordController.text,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(authViewmodelProvider, (previous, next) {
      next.whenOrNull(
        error: (error, stackTrace) {
          showErrorMessage(error.toString());
        },
        data: (_) {
          if (previous?.isLoading == true) {
            showSuccessMessage('Login successfully');
            context.goNamed(RouteNames.home);
          }
        },
      );
    });
    final obscurePassword = ref.watch(passwordVisibilityProvider);
    final isLoading = ref.watch(authViewmodelProvider).isLoading;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: -100,
            left: -50,
            child: Container(
              width: 250.w,
              height: 250.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primaryColor.withValues(
                  alpha: isDarkMode ? 0.15 : 0.08,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -80,
            right: -80,
            child: Container(
              width: 300.w,
              height: 300.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.secondaryColor.withValues(
                  alpha: isDarkMode ? 0.15 : 0.08,
                ),
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: middlePadding),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    gapXXL,
                    Center(
                      child: Container(
                        height: 70.w,
                        width: 70.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [
                              AppColors.primaryColor,
                              AppColors.secondaryColor,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          boxShadow: appShadow,
                        ),
                        child: Icon(
                          Icons.local_mall_rounded,
                          color: Colors.white,
                          size: 36.sp,
                        ),
                      ),
                    ),
                    gapLarge,
                    Center(
                      child: Text(
                        'ORAVCO',
                        style: context.textTheme.headlineMedium,
                      ),
                    ),
                    gapSmall,
                    Center(
                      child: Text(
                        'Discover & shop premium collections',
                        style: context.textTheme.bodySmall,
                      ),
                    ),
                    Gap(paddingXL * 1.5),

                    Text('Email Address', style: context.textTheme.bodySmall),
                    gapSmall,
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintText: 'Enter your email',
                        prefixIcon: Icon(
                          Icons.mail_outline_rounded,
                          color: isDarkMode
                              ? Colors.grey[400]
                              : Colors.grey[600],
                          size: 22.sp,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter your email';
                        }
                        final emailRegExp = RegExp(
                          r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                        );
                        if (!emailRegExp.hasMatch(value.trim())) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                    ),
                    gapLarge,
                    Text('Password', style: context.textTheme.bodySmall),

                    gapSmall,
                    TextFormField(
                      controller: _passwordController,
                      obscureText: obscurePassword,
                      textInputAction: TextInputAction.done,
                      enabled: !isLoading,
                      onFieldSubmitted: (_) => _submit(),
                      decoration: InputDecoration(
                        hintText: 'Enter your password',
                        prefixIcon: Icon(
                          Icons.lock_outline_rounded,
                          color: isDarkMode
                              ? Colors.grey[400]
                              : Colors.grey[600],
                          size: 22.sp,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            obscurePassword
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: isDarkMode
                                ? Colors.grey[400]
                                : Colors.grey[600],
                            size: 22.sp,
                          ),
                          onPressed: () {
                            ref
                                .read(passwordVisibilityProvider.notifier)
                                .update((state) => !state);
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                    gap,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          borderRadius: BorderRadius.circular(
                            defaultBorderRadius,
                          ),
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.all(paddingSmall),
                            child: Text(
                              'Forgot Password?',
                              style: context.textTheme.bodySmall,
                            ),
                          ),
                        ),
                      ],
                    ),
                    gapXL,
                    CommonButton(
                      buttonLoading: isLoading,
                      text: 'Sign In',
                      onPressed: _submit,
                    ),
                    gapLarge,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account? ",
                          style: context.textTheme.bodySmall?.copyWith(
                            color: isDarkMode
                                ? Colors.grey[400]
                                : Colors.grey[600],
                          ),
                        ),
                        gapSmall,
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            'Sign Up',
                            style: context.textTheme.bodySmall?.copyWith(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    gapLarge,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
