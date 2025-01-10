import 'package:dio/dio.dart';
import 'package:solar_energy/application/enums/storages_key.dart';
import 'package:solar_energy/data/data_sources/storage/shared_preferences/shared_preferences_helper.dart';
import 'package:solar_energy/data/dto/api_response/api_response.dart';
import 'package:solar_energy/di.dart';

class ApiInterceptors extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options,
      RequestInterceptorHandler handler) async {
    final sharePreferences = getIt<SharedPreferencesHelper>();

    final userToken =
    await sharePreferences.getStringValue(StoragesKey.accessToken);
    if (userToken.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $userToken';
    }
    options.headers['Cookie'] =
    '.AspNetCore.Antiforgery._hALYwUpIpc=CfDJ8Is7IlA92_VNrqV6zGIv6_Q0d2k-X3mrs_wakigvrQgeMojTqw7EhcPcCkJY9O7_WOD-UDr7WX_FlgrPT7eZtLS7g601c7Ub506R9XkM8jWSHwP9YpeXWrK0fZS-ElfEMiVyFfL8kSRuP9uUDDlVgjk; idsrv.session=58EA2C1A599CBEE73906DA24A5ED8358; XSRF-TOKEN=CfDJ8Is7IlA92_VNrqV6zGIv6_RlCAGsmL1Ief4G8qUergp4eFI4FAqu9SodLX7b-hTN7Dfy2H3ARg9LuACnP3Ladsd8Dq_85A0lTmEtxy6KlkHTsr4v5hhveyJLJIgwDvPdgYla21MeYvaJODmB44ijq9ifq1bRW7aRFqUpXoKzrk_S93NTge1et9zPV2D9UHjuyw; .AspNetCore.Identity.Application=CfDJ8Is7IlA92_VNrqV6zGIv6_Te4MIaLBDmSV9NBOA3hrvyydupLwcciHiNDLDVrmMM8PnSTKPkA-83wmDa3-aTXYP9Vy3tMfryMG1MO2W6_CMPlfeopQEEMzCQHHgYPMys6o3oOmJZv7dSXXNzOUR3DlfjGmRDa-ZQPDf3boWE52w4XF355RDPlSZjn9nkw35bZb4ZFqO4tHvmQx9kmoOE9pHVPzxFSNGEgZtaYvzgw0SQzHke7FOwXoH0xBOpAzgHvU7-K6KjkVMh968x-E4CFBlISOc071Tepi6Dl30dtU5zCvv1t9XhpHHIpq2ZgmVpOXftNKlylX2Nyd9FdxYPzaSQmsO85E-jzdVBFlAytosCRHY1jUb6ZmJw3bf0VcxL8I9-ZdGG2i05lvogMrobkc2ah22WOC7u55hVGwlrCsermX2wbKsRrlWG_9CWpg_UeNjWCQjBZaWHPkTdGqq7HoFnsUC-2lHoPPReVIKyhLbCKdMKwkaBNGDVVGI34dqeLlM2zIaX6pN4UhV6LH-DQe7VomPuBKtlbdTaoT3I11sp-Z7aDm0SpIx1LFpuKaXFX83wGOGszpxcx8y-45p0EdolsgZlURJK_1-1MjBqWoUlYCoshP4P9EFwNvvBE76DfbmescRP0Moccq-KrJ972TyoUkBZhQJTBWsmGD7vF_D0tgTzgKvmr6BH5bYU3bi89wuhJj_huZThZcYxYYkZJgv91QPhfGLUbxG-v1_MfU3yCVuMkpg21binx6ghMjd-xowuNOjoNewpFkrQJIaDHFCcttA1LgkRhOeOP_II1bS2MLDvod7YXWjeCNJFVtxrRSbnQB8EGeNsJFGas8uXqzaHVVrnb9F8UOelolVv_mkdIQW0AXW9onQbSZK4KFDDz8mQWEoM0CRP0m6mtyUcgoyMYY-2p4alBNXtJX_L0BmjxEfvw9PADds8snk6N6rOrG4XUzhgezwXqCtgNcHSWMipaVW2jxCgp9yT_lFG7MG0nojcIhlyM8iztkmdTfIrF8Wn9tFf8Dq9TfEZJ5fDHk-kd-eJIBkWDtciz36CZItdr73nNgg1Y9SC6oHu1DuX5WepkOAuankoiVPTCGFzMGa0q2E2YT1cONbX_Kqz2ShknIzZ4Sp88ikuH5Z0aKbsHW_6uAFU8JyuvBoazmWzBMOJuKqRLBBYqrEG5O2zplESsJpnJR5eIXdgR49DdYwyMG5kwuRK0tGCLK1AU1pBaGLlro2edIzdnbAtCH1gmyet';
    options.headers['X-Requested-With'] = 'XMLHttpRequest';
    options.headers['RequestVerificationToken'] =
    'CfDJ8Is7IlA92_VNrqV6zGIv6_RlCAGsmL1Ief4G8qUergp4eFI4FAqu9SodLX7b-hTN7Dfy2H3ARg9LuACnP3Ladsd8Dq_85A0lTmEtxy6KlkHTsr4v5hhveyJLJIgwDvPdgYla21MeYvaJODmB44ijq9ifq1bRW7aRFqUpXoKzrk_S93NTge1et9zPV2D9UHjuyw';
    return super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final response = err.response;
    if (response != null) {
      final Map<String, dynamic> data = response.data;
      if (data.containsKey('error')) {
        final ErrorResponse errorResponse =
        ErrorResponse.fromJson(data['error']);
        handler.reject(
          DioException(
            requestOptions: err.requestOptions,
            error: errorResponse, // Attach ErrorResponse
          ),
        );
        return;
      }
    }
    super.onError(err, handler);
  }
}
