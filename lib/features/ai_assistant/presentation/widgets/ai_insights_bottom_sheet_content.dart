import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../manager/ai_assistant_cubit.dart';
import '../manager/ai_assistant_state.dart';
import '../../domain/entities/ai_insight_entities.dart';

class AiInsightsBottomSheetContent extends StatefulWidget {
  const AiInsightsBottomSheetContent({super.key});

  @override
  State<AiInsightsBottomSheetContent> createState() => _AiInsightsBottomSheetContentState();
}

class _AiInsightsBottomSheetContentState extends State<AiInsightsBottomSheetContent> with SingleTickerProviderStateMixin {
  TabController? _tabController;

  // 🟢 كاش داخلي لحفظ التوصيات في الـ UI ومنع ظهور الشاشة البيضاء وقت الأكشنز
  AiInsightResponse? _cachedInsights;

  // 🟢 مصفوفات داخلية لتتبع الكروت التي تم ضغط لايك أو ديسلايك عليها تفاعلياً لايف
  final Set<String> _likedInsightIds = {};
  final Set<String> _dislikedInsightIds = {};

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController!.addListener(() {
      if (_tabController!.index == 1) {
        context.read<AiAssistantCubit>().fetchAdminFeedback();
      } else {
        context.read<AiAssistantCubit>().fetchAiInsights();
      }
    });
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // ================== HEADER ==================
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.close, color: Color(0xFF64748B)),
                onPressed: () => Navigator.pop(context),
              ),
              Row(
                children: [
                  Text(
                    "محرك الذكاء الاصطناعي الذكي",
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF111827),
                    ),
                  ),
                  SizedBox(width: 6.w),
                  Text("🧠", style: TextStyle(fontSize: 18.sp)),
                ],
              ),
            ],
          ),
          SizedBox(height: 10.h),

          // ================== TAB BAR ==================
          TabBar(
            controller: _tabController,
            labelColor: const Color(0xFF3B82F6),
            unselectedLabelColor: const Color(0xFF64748B),
            indicatorColor: const Color(0xFF3B82F6),
            labelStyle: TextStyle(fontFamily: 'Cairo', fontSize: 12.sp, fontWeight: FontWeight.bold),
            tabs: const [
              Tab(text: "التوصيات الحالية"),
              Tab(text: "تقييمات العملاء (Admin)"),
            ],
          ),
          SizedBox(height: 16.h),

          // ================== TAB BAR VIEW ==================
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildInsightsTab(),
                _buildAdminFeedbackTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 1️⃣ تبويب التوصيات الذكية مع زرار التوليد التيربو الجديد
  Widget _buildInsightsTab() {
    return BlocConsumer<AiAssistantCubit, AiAssistantState>(
      listener: (context, state) {
        if (state is AiActionSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("تم تسجيل تقييمك بنجاح ✨", textAlign: TextAlign.right, style: TextStyle(fontFamily: 'Cairo', fontSize: 12.sp)),
              backgroundColor: const Color(0xFF10B981),
              behavior: SnackBarBehavior.floating,
            ),
          );
          // جلب التوصيات مجدداً في الخلفية لتحديث حالة الـ Like/Dislike لايف
          context.read<AiAssistantCubit>().fetchAiInsights();
        }
        if (state is GenerateAiInsightsSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("تم تحديث وتوليد توصيات ذكية جديدة بنجاح 🚀", textAlign: TextAlign.right, style: TextStyle(fontFamily: 'Cairo', fontSize: 12.sp)),
              backgroundColor: const Color(0xFF3B82F6),
              behavior: SnackBarBehavior.floating,
            ),
          );
          context.read<AiAssistantCubit>().fetchAiInsights();
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            // محتوى اللستة وحالات الـ Loading
            Padding(
              padding: EdgeInsets.only(bottom: 60.h),
              child: _buildInsightsListContent(state),
            ),

            // زرار إضافة وتوليد توصيات جديدة تفاعلي عائم في الأسفل
            Positioned(
              bottom: 10.h,
              left: 0,
              right: 0,
              child: Center(
                child: SizedBox(
                  width: double.infinity,
                  height: 44.h,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1E293B),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                      elevation: 2,
                    ),
                    onPressed: (state is GenerateAiInsightsLoading)
                        ? null
                        : () {
                      context.read<AiAssistantCubit>().triggerFreshInsights();
                    },
                    icon: state is GenerateAiInsightsLoading
                        ? SizedBox(width: 16.w, height: 16.w, child: const CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                        : Icon(Icons.auto_awesome, color: Colors.amber, size: 16.sp),
                    label: Text(
                      state is GenerateAiInsightsLoading ? "جاري توليد التوصيات..." : "توليد توصيات ذكية جديدة",
                      style: TextStyle(fontFamily: 'Cairo', fontSize: 12.sp, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // ميثود الـ Content المحمي بالكاش لمنع الشاشة البيضاء تماماً
  Widget _buildInsightsListContent(AiAssistantState state) {
    if (state is GetAiInsightsLoading && _cachedInsights == null) {
      return const Center(child: CircularProgressIndicator(color: Color(0xFF3B82F6)));
    }
    else if (state is GetAiInsightsSuccess) {
      _cachedInsights = state.response;
    }
    else if (state is GetAiInsightsError && _cachedInsights == null) {
      return Center(child: Text(state.message, style: TextStyle(fontFamily: 'Cairo', color: Colors.red)));
    }

    if (_cachedInsights != null) {
      final insights = _cachedInsights!.items;
      if (insights.isEmpty) return _buildEmptyState("لا توجد توصيات ذكية حالياً.");
      return ListView.separated(
        itemCount: insights.length,
        separatorBuilder: (_, __) => SizedBox(height: 12.h),
        itemBuilder: (context, index) => _buildInsightCard(context, insights[index]),
      );
    }

    return const SizedBox.shrink();
  }

  // 2️⃣ تبويب تقييمات العملاء (Admin)
// 2️⃣ تبويب تقييمات العملاء (Admin) - محدث بالفلترة الذكية لمنع برجلة السيرفر
  Widget _buildAdminFeedbackTab() {
    return BlocBuilder<AiAssistantCubit, AiAssistantState>(
      builder: (context, state) {
        if (state is GetAdminFeedbackLoading) {
          return const Center(child: CircularProgressIndicator(color: Color(0xFF2563EB)));
        } else if (state is GetAdminFeedbackError) {
          return Center(child: Text(state.message, style: TextStyle(fontFamily: 'Cairo', color: Colors.red)));
        } else if (state is GetAdminFeedbackSuccess) {
          final List rawItems = state.feedbackData['items'] ?? [];

          // 🟢 الفلترة السحرية: استبعاد السجلات التاريخية الملغية عشان الشاشة تطلع نظيفة
          final List items = rawItems.where((item) {
            final String comment = item['comment']?.toString() ?? '';
            return comment != "تم إزالة التقييم";
          }).toList();

          if (items.isEmpty) return _buildEmptyState("لا توجد تقييمات مسجلة من العملاء حتى الآن.");

          return ListView.separated(
            itemCount: items.length,
            separatorBuilder: (_, __) => SizedBox(height: 12.h),
            itemBuilder: (context, index) {
              final item = items[index];
              final insight = item['insight'] ?? {};
              return Container(
                padding: EdgeInsets.all(12.r),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: const Color(0xFFCBD5E1)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              item['rating'] == 1 ? Icons.thumb_up : Icons.thumb_down,
                              color: item['rating'] == 1 ? const Color(0xFF10B981) : Colors.red,
                              size: 16.sp,
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              item['rating'] == 1 ? "مفيد" : "غير مفيد",
                              style: TextStyle(fontFamily: 'Cairo', fontSize: 10.sp, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Text(
                          "الشركة: ${item['tenantId']}",
                          style: TextStyle(fontFamily: 'Cairo', fontSize: 11.sp, color: const Color(0xFF64748B)),
                        ),
                      ],
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      "التوصية: ${insight['title'] ?? ''}",
                      style: TextStyle(fontFamily: 'Cairo', fontSize: 12.sp, fontWeight: FontWeight.bold),
                    ),
                    if (item['comment'] != null && item['comment'].toString().isNotEmpty) ...[
                      SizedBox(height: 4.h),
                      Text(
                        "تعليق العميل: ${item['comment']}",
                        textAlign: TextAlign.right,
                        style: TextStyle(fontFamily: 'Cairo', fontSize: 11.sp, color: const Color(0xFF0F172A), fontStyle: FontStyle.italic),
                      ),
                    ],
                  ],
                ),
              );
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
  // كرت التوصية الذكية المعدل تفاعلياً 100% بالـ Local State مع خاصية الـ Toggle
  Widget _buildInsightCard(BuildContext context, AiInsightEntity insight) {
    final bool isLiked = _likedInsightIds.contains(insight.id);
    final bool isDisliked = _dislikedInsightIds.contains(insight.id);

    return Container(
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                decoration: BoxDecoration(color: const Color(0xFFEFF6FF), borderRadius: BorderRadius.circular(6.r)),
                child: Text(insight.category.toUpperCase(), style: TextStyle(fontFamily: 'Cairo', fontSize: 9.sp, color: const Color(0xFF3B82F6), fontWeight: FontWeight.bold)),
              ),
              Text(insight.title, style: TextStyle(fontFamily: 'Cairo', fontSize: 13.sp, fontWeight: FontWeight.bold, color: const Color(0xFF111827))),
            ],
          ),
          SizedBox(height: 8.h),
          Text(insight.message, textAlign: TextAlign.right, style: TextStyle(fontFamily: 'Cairo', fontSize: 12.sp, color: const Color(0xFF475569), height: 1.4)),
          SizedBox(height: 12.h),
          const Divider(color: Color(0xFFE2E8F0)),

          // 🟢 الأزرار الذكية تدعم الـ Toggle المزدوج لايف
// 🟢 الأزرار الذكية المأمنة تماماً ضد البرجلة والتفسير الخاطئ للسيرفر
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                icon: Icon(
                  isDisliked ? Icons.thumb_down : Icons.thumb_down_outlined,
                  size: 18.sp,
                  color: isDisliked ? Colors.red : const Color(0xFF94A3B8),
                ),
                onPressed: () {
                  setState(() {
                    if (isDisliked) {
                      _dislikedInsightIds.remove(insight.id); // إزالة الديسلايك موضعياً
                    } else {
                      _dislikedInsightIds.add(insight.id);
                      _likedInsightIds.remove(insight.id); // إلغاء اللايك العكسي لو موجود

                      // 🟢 نبعت للسيرفر فقط في حالة التقييم الفعلي (0)
                      context.read<AiAssistantCubit>().submitInsightFeedback(
                        insightId: insight.id,
                        rating: 0,
                        comment: "غير مفيدة",
                      );
                    }
                  });
                },
              ),
              SizedBox(width: 8.w),
              IconButton(
                icon: Icon(
                  isLiked ? Icons.thumb_up : Icons.thumb_up_outlined,
                  size: 18.sp,
                  color: isLiked ? const Color(0xFF3B82F6) : const Color(0xFF94A3B8),
                ),
                onPressed: () {
                  setState(() {
                    if (isLiked) {
                      _likedInsightIds.remove(insight.id); // إزالة اللايك موضعياً
                    } else {
                      _likedInsightIds.add(insight.id);
                      _dislikedInsightIds.remove(insight.id); // إلغاء الديسلايك العكسي لو موجود

                      // 🟢 نبعت للسيرفر فقط في حالة التقييم الفعلي (1)
                      context.read<AiAssistantCubit>().submitInsightFeedback(
                        insightId: insight.id,
                        rating: 1,
                        comment: "مفيدة جداً",
                      );
                    }
                  });
                },
              ),
            ],
          ),        ],
      ),
    );
  }

  Widget _buildEmptyState(String msg) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("✨", style: TextStyle(fontSize: 28.sp)),
          SizedBox(height: 8.h),
          Text(msg, textAlign: TextAlign.center, style: TextStyle(fontFamily: 'Cairo', fontSize: 12.sp, color: const Color(0xFF64748B))),
        ],
      ),
    );
  }
}