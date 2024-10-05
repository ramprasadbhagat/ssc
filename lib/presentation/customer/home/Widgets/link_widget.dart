part of '../customer_home_page.dart';

class LinkWidget extends StatelessWidget {
  final String facebookUrl =
      'https://www.facebook.com/people/Sunrise-Service-Centre/61561209825720/';
  final String youtubeUrl =
      'https://www.youtube.com/channel/UCF0q5z-sMZUs18nTsep9Nhg';

  Future<void> _launchUrl(String url) async {
    final link = Uri.parse(url);
    if (!await launchUrl(link, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url)');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 20.0.h, left: 5.0.w, bottom: 2.0.h),
          child: Text(
            'Supported Channels',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ),
        Center(
          child: BlocConsumer<SocialMediaBloc, SocialMediaState>(
            listenWhen: (previous, current) => previous.apiFailureOrSuccessOption !=current.apiFailureOrSuccessOption,
            listener: (context, state) {
            state.apiFailureOrSuccessOption.fold(() {}, (either) async {
              either.fold((leftMessage) {
                CustomSnackbar.showErrorMessage(
                  context,
                  leftMessage,
                );
              }, (_) {});
            });
          },
            buildWhen: (previous, current) => previous.isLoading != current.isLoading,
            builder: (context, state) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildCard(
                    context,
                    'Facebook',
                    Icons.facebook,
                    facebookUrl,
                    Colors.blue,
                    state.isLoading,
                  ),
                  _buildCard(
                    context,
                    'YouTube',
                    Icons.video_library,
                    youtubeUrl,
                    Colors.red,
                    state.isLoading,
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCard(
    BuildContext context,
    String title,
    IconData icon,
    String url,
    Color color,
    bool isLoading,
  ) {
    return GestureDetector(
      onTap: () => _launchUrl(url),
      child: Card(
        elevation: 3,
        margin: EdgeInsets.all(10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: LoadingShimmer.withChild(
          enabled: isLoading,
          child: Container(
            width: 0.42.mw,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: color,
            ),
            padding: EdgeInsets.symmetric(vertical: 6.0.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 30, color: Colors.white),
                SizedBox(width: 10),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
